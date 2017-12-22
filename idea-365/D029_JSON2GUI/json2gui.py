import json
import codecs
import tkinter as tk
import tkinter.ttk as ttk


def read_json_file(json_file):
    with codecs.open(json_file, 'r', "utf-8") as f:
        data = json.load(f)
    return data


# 从json文件创建UI
def create_ui(self, json_file):
    widget = read_json_file(json_file)

    if widget:
        for k in widget:
            # "class"和"grid"参数不存在直接弹出异常
            if not widget[k].get("class"):
                raise NameError("Parameter loss: class")

            if not widget[k].get("grid"):
                raise NameError("Parameter loss: grid")

            widget_class = widget[k]["class"]
            widget_grid = widget[k]["grid"]
            widget_str_parm = widget[k]["string"] if widget[k].get("string") else {}
            widget_int_parm = widget[k]["int"] if widget[k].get("int") else {}
            widget_var = widget[k]["var"] if widget[k].get("var") else None

            # 动态生成控件，并添加字符串类型的参数（若有）
            self.__dict__[k] = tk.__dict__[widget_class](self, **widget_str_parm)
            # 为每个控件添加数值类型的参数（若有）
            for pk in widget_int_parm:
                self.__dict__[k][pk] = int(widget_int_parm[pk])
            # 为每个控件绑定变量（若有）
            if widget_var:
                self.__dict__[widget_var] = tk.StringVar()
                self.__dict__[k]["textvariable"] = self.__dict__[widget_var]
            # 使用grid布局控件
            self.__dict__[k].grid(**widget_grid)


# 绑定控件的指令
def create_command(self, widget, command):
    self.__dict__[widget]["command"] = command


# 绑定事件
def create_bind(self, widget, event_handle):
    self.__dict__[widget].bind("<Button-1>", event_handle)
