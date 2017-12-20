from xml.parsers.expat import ParserCreate
import tkinter as tk
import tkinter.ttk as ttk
import logging

logging.basicConfig(level=logging.INFO)


# xml解析类
class MySaxHandler(object):
    def __init__(self):
        self.window = None
        self.stack = []

    def start_element(self, name, attrs):
        if name == 'Root':
            self.window = {}
        else:
            if not self.stack:
                self.window[name] = {}
                self.stack.append(name)
            else:
                self.window[self.stack[-1]][name] = attrs

    def end_element(self, name):
        if self.stack and self.stack[-1] == name:
            self.stack.pop()
        elif name == 'Root':
            logging.info(str(self.window))

    def char_data(self, text):
        pass


# 从xml文件自动设置UI控件
def create_ui(self, xml_file):
    try:
        with open(xml_file, 'r', encoding='utf-8') as f:
            xml = f.read()
        if xml:
            handler = MySaxHandler()
            parser = ParserCreate()
            parser.StartElementHandler = handler.start_element
            parser.EndElementHandler = handler.end_element
            parser.CharacterDataHandler = handler.char_data
            parser.Parse(xml)
            widget = handler.window
        else:
            widget = {}
    except Exception as err:
        widget = {}
        logging.error('Err: %s' % err)

    if widget:
        for k in widget:
            widget_class = widget[k]["type"]["name"]
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
                self.__dict__[widget_var["name"]] = tk.StringVar()
                self.__dict__[k]["textvariable"] = self.__dict__[widget_var["name"]]
            self.__dict__[k].grid(**widget[k]["grid"])


# 绑定控件的指令
def create_command(self, widget, command):
    self.__dict__[widget]["command"] = command
