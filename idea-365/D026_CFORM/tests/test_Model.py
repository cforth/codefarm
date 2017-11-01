from CFORM.Model import *


class User(Model):
    # 定义类的属性到列的映射：
    id = IntegerField('id', primary_key=True)
    username = StringField('username')
    email = StringField('email')
    password = StringField('password')


# 新建数据库和数据表
if not User.has_table():
    User.new_table()

# 将数据存入数据表中
u = User(id=1, username='cf', email='cforth@cfxyzom', password='hello')
if not User.find("username", u.username):
    u.save()

u = User(id=2, username='xxx', email='xxx@cfxyzom', password='world')
if not User.find("username", u.username):
    u.save()
