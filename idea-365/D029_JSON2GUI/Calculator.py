from json2gui import *
import tkinter as tk


class Window(tk.Frame):
    def __init__(self, ui_json, master=None):
        super().__init__(master)
        # 从json自动设置UI控件
        create_ui(self, ui_json)
        # 从json自动绑定事件
        create_all_binds(self, ui_json)
        self.cache = ""
        self.grid(row=0, column=0)

    def callback(self, event):
        # 取出事件发生的按钮对应的符号或数字
        symbol = event.widget["text"]
        # 控制和计算
        if symbol == "<-":
            if self.cache:
                self.cache = self.cache[:-1]
        elif symbol == "AC":
            self.cache = ""
        elif symbol == "=":
            # 直接使用eval函数计算
            self.cache = str(eval(self.cache))
        else:
            self.cache += symbol
        # 显示出来
        getattr(self, "output").set(self.cache)


app = Window("UI.json")
# 设置窗口标题:
app.master.title("计算器")
# 主消息循环:
app.mainloop()
