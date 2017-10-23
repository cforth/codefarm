from DataModel import *
import unittest
import os


# 数据vo类必须在参数列表指定默认值
class PasswordData(object):
    def __init__(self, name=None, password=None):
        self.name = name
        self.password = password

    def __eq__(self, obj):
        return type(self) == type(obj) \
               and self.name == obj.name \
               and self.password == obj.password

    def __str__(self):
        return "name = " + self.name + ", password = " + self.password


class TestDataMode(unittest.TestCase):
    def test_new_table(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        res = table_model.new_table()
        self.assertTrue(res)
        res = table_model.new_table()
        self.assertFalse(res)
        os.remove("./password_db.db")

    def test_has_table(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        res = table_model.has_table()
        self.assertFalse(res)
        table_model.new_table()
        res = table_model.has_table()
        self.assertTrue(res)
        os.remove("./password_db.db")

    def test_del_table(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        res = table_model.del_table()
        self.assertTrue(res)
        res = table_model.del_table()
        self.assertFalse(res)
        os.remove("./password_db.db")

    def test_create(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        vo = PasswordData("your", "your_password")
        res = table_model.create(vo)
        self.assertEqual(res, 1)
        os.remove("./password_db.db")

    def test_retrieve(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        vo1 = PasswordData("your", "your_password")
        vo2 = PasswordData("me", "hello")
        vo3 = PasswordData("Jack", "lsjdf23dfs")
        table_model.create(vo1)
        table_model.create(vo2)
        table_model.create(vo3)
        res = table_model.retrieve("name", "Jack")
        obj = PasswordData("Jack", "lsjdf23dfs")
        self.assertEqual(res, obj)
        res = table_model.retrieve("name", "not_this_name")
        self.assertEqual(res, None)
        os.remove("./password_db.db")

    def test_create_batch_and_retrieve_limit(self):
        table_name = 'password_db'
        table_model = DataModel(table_name, PasswordData)
        table_model.new_table()
        l = []
        for x in range(0, 5):
            l.append(PasswordData('111' + str(x), '222'))
        table_model.create_batch(l)
        self.assertEqual(table_model.retrieve("name", "1110"), PasswordData('1110', '222'))
        self.assertEqual(table_model.retrieve("name", "1114"), PasswordData('1114', '222'))
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