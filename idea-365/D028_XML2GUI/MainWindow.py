from xml2gui import *
import tkinter as tk
import tkinter.filedialog as filedialog
import tkinter.ttk as ttk


class Window(ttk.Frame):
    def __init__(self, master=None):
        super().__init__(master, padding=2)
        # 从xml文件自动设置UI控件
        create_ui_from_xml(self, "my_window.xml")
        self.create_bindings()
        self.grid(row=0, column=0)

    def create_bindings(self):
        # 以下控件没有手工定义，由create_ui_from_xml生成
        self.passwordShowButton["command"] = self.password_show_button_callback
        self.fileFromButton["command"] = self.file_from_button_callback
        self.fileToButton["command"] = self.file_to_button_callback
        self.doButton["command"] = self.do_button_callback

    def password_show_button_callback(self, event=None):
        self.passwordEntry["show"] = "" if self.passwordEntry["show"] == "*" else "*"

    def file_from_button_callback(self, event=None):
        self.fileFrom.set(filedialog.askopenfilename())

    def file_to_button_callback(self, event=None):
        self.fileTo.set(filedialog.askdirectory())

    def do_button_callback(self, event=None):
        self.info.set("密码：%s\n 输入路径：%s\n 输出路径：%s" % (self.password.get(), self.fileFrom.get(), self.fileTo.get()))


app = Window()
# 设置窗口标题:
app.master.title('测试')
# 主消息循环:
app.mainloop()