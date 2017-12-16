from xml2gui import *
import tkinter as tk
import tkinter.ttk as ttk


class Window(ttk.Frame):
    def __init__(self, master=None):
        super().__init__(master, padding=2)
        create_ui_from_xml(self, "my_window.xml")
        self.create_bindings()
        self.grid(row=0, column=0)

    def create_bindings(self):
        self.doButton.bind("<Button-1>", lambda event: print("sadfasdf"))


app = Window()
# 设置窗口标题:
app.master.title('测试')
# 主消息循环:
app.mainloop()