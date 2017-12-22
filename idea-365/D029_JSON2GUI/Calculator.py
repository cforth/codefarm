from json2gui import *
import tkinter as tk


class Window(tk.Frame):
    def __init__(self, master=None):
        super().__init__(master)
        # 从xml文件自动设置UI控件
        create_ui(self, "UI.json")
        create_bind(self, "oneButton", self.callback)
        create_bind(self, "twoButton", self.callback)
        create_bind(self, "threeButton", self.callback)
        create_bind(self, "fourButton", self.callback)
        create_bind(self, "fiveButton", self.callback)
        create_bind(self, "sixButton", self.callback)
        create_bind(self, "sevenButton", self.callback)
        create_bind(self, "eightButton", self.callback)
        create_bind(self, "nineButton", self.callback)
        create_bind(self, "zeroButton", self.callback)
        create_bind(self, "spotButton", self.callback)
        create_bind(self, "plusButton", self.callback)
        create_bind(self, "minusButton", self.callback)
        create_bind(self, "mulButton", self.callback)
        create_bind(self, "divButton", self.callback)
        create_bind(self, "backButton", self.callback)
        create_bind(self, "acButton", self.callback)
        create_bind(self, "equalButton", self.callback)
        create_bind(self, "modButton", self.callback)
        self.cache = ""
        self.grid(row=0, column=0)

    def callback(self, event):
        if event.widget == self.oneButton:
            self.cache += "1"
        elif event.widget == self.twoButton:
            self.cache += "2"
        elif event.widget == self.threeButton:
            self.cache += "3"
        elif event.widget == self.fourButton:
            self.cache += "4"
        elif event.widget == self.fiveButton:
            self.cache += "5"
        elif event.widget == self.sixButton:
            self.cache += "6"
        elif event.widget == self.sevenButton:
            self.cache += "7"
        elif event.widget == self.eightButton:
            self.cache += "8"
        elif event.widget == self.nineButton:
            self.cache += "9"
        elif event.widget == self.zeroButton:
            self.cache += "0"
        elif event.widget == self.spotButton:
            self.cache += "."
        elif event.widget == self.plusButton:
            self.cache += "+"
        elif event.widget == self.minusButton:
            self.cache += "-"
        elif event.widget == self.mulButton:
            self.cache += "*"
        elif event.widget == self.divButton:
            self.cache += "/"
        elif event.widget == self.modButton:
            self.cache += "%"
        elif event.widget == self.backButton:
            if self.cache:
                self.cache = self.cache[:-1]
        elif event.widget == self.acButton:
            self.cache = ""
        elif event.widget == self.equalButton:
            self.cache = str(eval(self.cache))

        self.output.set(self.cache)


app = Window()
# 设置窗口标题:
app.master.title('计算器')
# 主消息循环:
app.mainloop()