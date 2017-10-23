"""Data model, Operation database"""
import sqlite3


class DataModel(object):
    # 使用同样的名字命名数据库名称与数据表名称，并且一个数据库中只包含一个数据表
    def __init__(self, db_name, data_class):
        self._db_name = db_name
        self._file_name = self._db_name + '.db'
        self.data_class = data_class
        self._db_field_list = [x for x in dir(data_class()) if '__' not in x]
        self._db_field_count = len(self._db_field_list)

    # 数据库操作，负责连接、提交事务、断开数据库，返回操作的行数与结果列表
    def _db_operate(self, execute_str, execute_args=None):
        result = None
        conn = sqlite3.connect(self._file_name)
        row_size = 0
        try:
            cursor = conn.cursor()
            if execute_args:
                cursor.execute(execute_str, execute_args)
            else:
                cursor.execute(execute_str)
            result = cursor.fetchall()
            row_size = cursor.rowcount
            cursor.close()
            conn.commit()
        except Exception as e:
            print(e)
        finally:
            conn.close()
        return row_size, result

    # 测试数据表是否存在
    def has_table(self):
        execute_str = "select count(*) from sqlite_master where type=? and name=?"
        row_size, result = self._db_operate(execute_str, ("table", self._db_name))
        return True if result[0][0] else False

    # 新建一个数据表
    def new_table(self):
        execute_str = 'create table %s (' % self._db_name
        for i in range(0, self._db_field_count - 1):
            execute_str += (' %s text, ' % self._db_field_list[i])
        execute_str += (' %s text )' % self._db_field_list[-1])
        row_size, result = self._db_operate(execute_str)
        return True if row_size else False

    # 删除一个数据表
    def del_table(self):
        execute_str = 'drop table %s' % self._db_name
        row_size, result = self._db_operate(execute_str)
        return True if row_size else False

    # 增加一行数据
    def create(self, obj):
        data = []
        for i in range(0, self._db_field_count):
            data.append(getattr(obj, self._db_field_list[i]))
        execute_str = 'insert into %s (' % self._db_name
        for i in range(0, self._db_field_count - 1):
            execute_str += ' %s, ' % self._db_field_list[i]
        execute_str += '%s ) values(' % self._db_field_list[-1]
        for i in range(0, self._db_field_count - 1):
            execute_str += ' ?, '
        execute_str += '? )'
        row_size, result = self._db_operate(execute_str, tuple(data))
        return row_size

    # 增加多行数据
    def create_batch(self, obj_list):
        data_list = []
        for x in obj_list:
            data = []
            for i in range(0, self._db_field_count):
                data.append(getattr(x, self._db_field_list[i]))
            data_list.append(data)
        execute_str = 'insert into %s (' % self._db_name
        for i in range(0, self._db_field_count - 1):
            execute_str += ' %s, ' % self._db_field_list[i]
        execute_str += '%s ) values(' % self._db_field_list[-1]
        for i in range(0, self._db_field_count - 1):
            execute_str += ' ?, '
        execute_str += '? )'
        row_size = 0
        conn = sqlite3.connect(self._file_name)
        try:
            cursor = conn.cursor()
            for i in range(0, len(data_list)):
                cursor.execute(execute_str, tuple(data_list[i]))
            row_size = cursor.rowcount
            cursor.close()
            conn.commit()
        except Exception as e:
            print(e)
        finally:
            conn.close()
        return row_size

    # 根据键值检索一行数据
    def retrieve(self, key, value):
        row_size, col_list = self._db_operate("PRAGMA table_info(%s)" % self._db_name)
        col_name_list = [col[1] for col in col_list]
        execute_str = 'select * from %s where %s = ?' % (self._db_name, key)
        row_size, result = self._db_operate(execute_str, (value,))
        if result:
            res_dict = dict(zip(col_name_list, result[0]))
            res_obj = self.data_class(**res_dict)
            return res_obj
        else:
            return None

    # 根据id检索多行数据
    def retrieve_limit(self, start_id, end_id):
        execute_str = 'select * from %s limit ?, ?' % self._db_name
        row_size, result = self._db_operate(execute_str, (start_id, end_id))
        res_obj_list = [self.data_class(*args) for args in result]
        return res_obj_list

    # 更新一行数据
    def update(self, column_key, column_value, key, value):
        execute_str = "update %s set %s = ? where %s = ?" % (self._db_name, key, column_key)
        row_size, result = self._db_operate(execute_str, (value, column_value))
        return row_size

    # 删除一行数据
    def delete(self, key, value):
        execute_str = "delete from %s WHERE %s = ?" % (self._db_name, key)
        row_size, result = self._db_operate(execute_str, (value,))
        return row_size
