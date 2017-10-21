from DataModel import *
import unittest
import os


# 数据vo类必须在参数列表指定默认值
class PasswordData(object):
    def __init__(self, name=None, password=None):
        self.name = name
        self.password = password


class TestDataMode(unittest.TestCase):
    def test_new_table(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        self.assertTrue(os.path.exists("./password_db.db"))
        os.remove("./password_db.db")

    def test_has_table(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        self.assertEqual(table_model.has_table(), 1)
        os.remove("./password_db.db")

    def test_del_table(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        self.assertEqual(table_model.has_table(), 1)
        table_model.del_table()
        self.assertEqual(table_model.has_table(), 0)
        os.remove("./password_db.db")

    def test_create_and_retrieve(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        vo = PasswordData("your", "your_password")
        table_model.create(vo)
        res = table_model.retrieve("name", "your")
        self.assertEqual(res, [(1, 'your', 'your_password')])
        res = table_model.retrieve("name", "not_this_name")
        self.assertEqual(res, [])
        os.remove("./password_db.db")

    def test_create_batch_and_retrieve_limit(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        l = []
        for x in range(0, 5):
            l.append(PasswordData('111' + str(x), '222'))
        table_model.create_batch(l)
        self.assertEqual(table_model.retrieve("name", "1110"), [(1, '1110', '222')])
        self.assertEqual(table_model.retrieve("name", "1114"), [(5, '1114', '222')])
        self.assertEqual(len(table_model.retrieve_limit(1, 3)), 3)
        os.remove("./password_db.db")

    def test_update(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        l = []
        for x in range(1, 6):
            l.append(PasswordData('No' + str(x), str(x)))
        table_model.create_batch(l)
        row_size = table_model.update("name", "No3", "password", "new_password")
        self.assertEqual(row_size, 1)
        row_size = table_model.update("name", "No8", "password", "new_password")
        self.assertEqual(row_size, 0)
        os.remove("./password_db.db")

    def test_delete(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        l = []
        for x in range(1, 6):
            l.append(PasswordData('No' + str(x), str(x)))
        table_model.create_batch(l)
        row_size = table_model.delete("name", "No5")
        self.assertEqual(row_size, 1)
        row_size = table_model.delete("name", "No8")
        self.assertEqual(row_size, 0)
        os.remove("./password_db.db")


if __name__ == '__main__':
    unittest.main()