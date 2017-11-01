import sqlite3


# 数据库操作，负责连接、提交事务、断开数据库，返回操作的行数与结果列表
def operate(db_name, execute_str, execute_args=None):
    result = None
    conn = sqlite3.connect(db_name + ".db")
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