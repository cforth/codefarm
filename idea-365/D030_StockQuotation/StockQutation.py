from CFTookit.json2gui import *
import tkinter as tk
import requests
import json
import re
import logging

logging.basicConfig(level=logging.INFO)


class Window(tk.Frame):
    def __init__(self, ui_json, master=None):
        super().__init__(master)
        # 从json自动设置UI控件
        create_ui(self, ui_json)
        # 从json自动绑定事件
        create_all_binds(self, ui_json)
        self.grid(row=0, column=0)

    def get_quotation(self, event):
        stock_code = self.__dict__["stockCode"].get()
        if not re.match(r"^\d{6}$", stock_code):
            getattr(self, "output").set("")
            raise ValueError("Stock Code Error")

        # 添加0或1在股票代码之前，满足获取行情的API需要
        if stock_code[0] == "0" or stock_code[0] == "3":
            stock_code = "1" + stock_code
        else:
            stock_code = "0" + stock_code

        url = "http://api.money.126.net/data/feed/" + stock_code + ",money.api"
        result = requests.get(url).content.decode()
        json_str = result[result.index("(") + 1:result.rindex(")")]
        data_dict = json.loads(json_str)
        if data_dict:
            now_time = data_dict[stock_code]["time"]
            stock_symbol = data_dict[stock_code]["symbol"]
            stock_name = data_dict[stock_code]["name"]
            now_price = data_dict[stock_code]["price"]
            percent = data_dict[stock_code]["percent"] * 100.0
            updown = data_dict[stock_code]["updown"]
            logging.info(str(data_dict))
            quotation = "名称:%s\n代码:%s\n价格:%.2f\n涨跌幅:%.2f%%\n涨跌价:%.2f\n时间:%s" % \
                        (stock_name, stock_symbol, now_price, percent, updown, now_time)
            getattr(self, "output").set(quotation)
        else:
            getattr(self, "output").set("")


app = Window("UI.json")
# 设置窗口标题:
app.master.title("股票行情")
# 主消息循环:
app.mainloop()
