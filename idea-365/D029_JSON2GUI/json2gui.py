import json
import codecs
import tkinter as tk
import logging
logging.basicConfig(level=logging.INFO)


def read_json_file(json_file):
    with codecs.open(json_file, 'r', "utf-8") as f:
        data = json.load(f)
    return data


# 从json文件创建UI
def create_ui(self, json_file):
    widget = read_json_file(json_file)
    logging.info("JSON Object: %s" % str(widget))

    if not widget:
        raise NameError("JSON is empty")

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
        if widget_grid.get("sticky"):
            grid_sticky = []
            for p in widget_grid["sticky"]:
                if p == "E":
                    grid_sticky.append(tk.E)
                elif p == "W":
                    grid_sticky.append(tk.W)
                elif p == "N":
                    grid_sticky.append(tk.N)
                elif p == "S":
                    grid_sticky.append(tk.S)
            widget_grid.pop("sticky")
            self.__dict__[k].grid(sticky=tuple(grid_sticky), **widget_grid)
        else:
            self.__dict__[k].grid(**widget_grid)


# 通过json文件给控件绑定事件（若有）
def create_all_binds(self, json_file):
    widget = read_json_file(json_file)
    for k in widget:
        if widget[k].get("bind"):
            for w in widget[k]["bind"]:
                # 通过绑定方法的名称，来动态绑定给控件绑定事件
                self.__dict__[k].bind(w, getattr(self, widget[k]["bind"][w]))
