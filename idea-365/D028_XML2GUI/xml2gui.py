from xml.parsers.expat import ParserCreate
import tkinter as tk
import tkinter.ttk as ttk
import logging

logging.basicConfig(level=logging.INFO)
XML_FILE = "my_window.xml"


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


class WindowMetaclass(type):
    def __new__(cls, name, bases, attrs):
        try:
            with open(XML_FILE, 'r', encoding='utf-8') as f:
                xml = f.read()
            if xml:
                handler = MySaxHandler()
                parser = ParserCreate()
                parser.StartElementHandler = handler.start_element
                parser.EndElementHandler = handler.end_element
                parser.CharacterDataHandler = handler.char_data
                parser.Parse(xml)
                attrs['my_widget'] = handler.window
        except Exception as err:
            attrs['my_widget'] = {}
            logging.error('Err: %s' % err)
        return type.__new__(cls, name, bases, attrs)


class Window(ttk.Frame, metaclass=WindowMetaclass):
    def __init__(self, master=None):
        super().__init__(master, padding=2)
        self.set_ui_from_xml()
        self.grid(row=0, column=0)

    # 从xml文件自动设置UI控件
    def set_ui_from_xml(self):
        widget = Window.__dict__['my_widget'] if Window.__dict__.get('my_widget') else None
        if widget:
            for k in widget:
                widget_str_parm = widget[k]["strParm"] if widget[k].get("strParm") else {}
                widget_int_parm = widget[k]["intParm"] if widget[k].get("intParm") else {}
                widget_var = widget[k]["var"] if widget[k].get("var") else None

                # 动态生成控件，并添加字符串类型的参数（若有）
                if widget[k]["type"]["type"] == "Entry":
                    self.__dict__[k] = ttk.Entry(self, **widget_str_parm)
                elif widget[k]["type"]["type"] == "Button":
                    self.__dict__[k] = ttk.Button(self, **widget_str_parm)
                elif widget[k]["type"]["type"] == "Label":
                    self.__dict__[k] = ttk.Label(self, **widget_str_parm)
                # 为每个控件添加数值类型的参数（若有）
                for pk in widget_int_parm:
                    self.__dict__[k][pk] = int(widget_int_parm[pk])
                # 为每个控件绑定变量（若有）
                if widget_var:
                    self.__dict__[widget_var["name"]] = tk.StringVar()
                    self.__dict__[k]["textvariable"] = self.__dict__[widget_var["name"]]
                self.__dict__[k].grid(**widget[k]["grid"])


app = Window()
# 设置窗口标题:
app.master.title('测试')
# 主消息循环:
app.mainloop()
