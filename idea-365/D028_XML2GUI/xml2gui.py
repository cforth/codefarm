from xml.parsers.expat import ParserCreate
from tkinter import *

global_window = None

class DefaultSaxHandler(object):
    def start_element(self, name, attrs):
        global global_window
        if name == "Window":
            global_window = {}
            for k in attrs:
                global_window[k] = attrs[k]
        elif isinstance(global_window, dict):
                global_window[name] = attrs

    def end_element(self, name):
        if name == "Window":
            pass

    def char_data(self, text):
        pass



class WindowMetaclass(type):
    def __new__(cls, name, bases, attrs):
        global global_window
        with open('my_window.xml', 'r', encoding='utf-8') as f:
            xml = f.read()
        if xml:
            handler = DefaultSaxHandler()
            parser = ParserCreate()
            parser.StartElementHandler = handler.start_element
            parser.EndElementHandler = handler.end_element
            parser.CharacterDataHandler = handler.char_data
            parser.Parse(xml)
            attrs['my_widget'] = global_window
        return type.__new__(cls, name, bases, attrs)


class Window(Frame, metaclass=WindowMetaclass):
    def __init__(self, master=None):
        Frame.__init__(self, master)
        for k in self.my_widget:
            if self.my_widget[k]["type"] == "Entry":
                self.__dict__[k] = Entry(self, text=self.my_widget[k]["text"])
            elif self.my_widget[k]["type"] == "Button":
                self.__dict__[k] = Button(self, text=self.my_widget[k]["text"])
            self.__dict__[k].grid(row=int(self.my_widget[k]["row"]), column=int(self.my_widget[k]["column"]))
        self.grid(row=0, column=0)


app = Window()
# 设置窗口标题:
app.master.title('Hello World')
# 主消息循环:
app.mainloop()
