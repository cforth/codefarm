from json2gui import *
import tkinter as tk
import tkinter.filedialog as filedialog
import tkinter.ttk as ttk


class Window(ttk.Frame):
    def __init__(self, master=None):
        super().__init__(master, padding=2)
        # 从json文件自动设置UI控件
        create_ui(self, "UI.json")
        self.grid(row=0, column=0)
        # 为控件绑定指令
        create_command(self, "passwordShowButton", self.password_show_button_callback)
        create_command(self, "fileFromButton", self.file_from_button_callback)
        create_command(self, "fileToButton", self.file_to_button_callback)
        create_command(self, "doButton", self.do_button_callback)

    def password_show_button_callback(self, event=None):
        self.__dict__["passwordEntry"]["show"] = "" if self.__dict__["passwordEntry"]["show"] == "*" else "*"

    def file_from_button_callback(self, event=None):
        self.__dict__["fileFrom"].set(filedialog.askopenfilename())

    def file_to_button_callback(self, event=None):
        self.__dict__["fileTo"].set(filedialog.askdirectory())

    def do_button_callback(self, event=None):
        self.__dict__["info"].set("密码：%s\n输入路径：%s\n输出路径：%s" %
                                  (self.__dict__["password"].get(),
                                   self.__dict__["fileFrom"].get(),
                                   self.__dict__["fileTo"].get()))


app = Window()
# 设置窗口标题:
app.master.title('测试')
# 主消息循环:
app.mainloop()
