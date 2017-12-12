from xml.parsers.expat import ParserCreate
import tkinter.ttk as ttk
import logging

logging.basicConfig(level=logging.ERROR)
XML_FILE = "my_window.xml"


class MySaxHandler(object):
    def __init__(self):
        self.window = None

    def start_element(self, name, attrs):
        if name == "Root":
            self.window = {}
            for k in attrs:
                self.window[k] = attrs[k]
        elif isinstance(self.window, dict):
            self.window[name] = attrs

    def end_element(self, name):
        if name == "Root":
            logging.info(self.window)

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
        self.create_widgets_layout()
        self.grid(row=0, column=0)

    def create_widgets_layout(self):
        widgets = Window.__dict__['my_widget'] if Window.__dict__.get('my_widget') else None
        if widgets:
            for k in widgets:
                if widgets[k]["type"] == "Entry":
                    self.__dict__[k] = ttk.Entry(self, text=widgets[k]["text"])
                elif widgets[k]["type"] == "Button":
                    self.__dict__[k] = ttk.Button(self, text=widgets[k]["text"])
                elif widgets[k]["type"] == "Label":
                    self.__dict__[k] = ttk.Label(self, text=widgets[k]["text"])
                self.__dict__[k].grid(row=int(widgets[k]["row"]), column=int(widgets[k]["column"]))


app = Window()
# 设置窗口标题:
app.master.title('测试')
# 主消息循环:
app.mainloop()