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
            widget_class = widget[k]["type"]
            widget_str_parm = widget[k]["strParm"] if widget[k].get("strParm") else {}
            widget_int_parm = widget[k]["intParm"] if widget[k].get("intParm") else {}
            widget_var = widget[k]["var"] if widget[k].get("var") else None

            # 动态生成控件，并添加字符串类型的参数（若有）
            self.__dict__[k] = ttk.__dict__[widget_class](self, **widget_str_parm)
            # 为每个控件添加数值类型的参数（若有）
            for pk in widget_int_parm:
                self.__dict__[k][pk] = int(widget_int_parm[pk])
            # 为每个控件绑定变量（若有）
            if widget_var:
                self.__dict__[widget_var] = tk.StringVar()
                self.__dict__[k]["textvariable"] = self.__dict__[widget_var]
            self.__dict__[k].grid(**widget[k]["grid"])


# 绑定控件的指令
def create_command(self, widget, command):
    self.__dict__[widget]["command"] = command
