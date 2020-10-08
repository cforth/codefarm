import tkinter.ttk as ttk
import tkinter as tk
import logging
from socket import *
import threading

logging.basicConfig(level=logging.ERROR)
TEXT_DEFAULT_SIZE = 12


# 设置滚动条与框体的绑定
def set_scrollbar(widget, scrollbar_x, scrollbar_y):
    scrollbar_y["command"] = widget.yview
    scrollbar_x["command"] = widget.xview
    widget['xscrollcommand'] = scrollbar_x.set
    widget['yscrollcommand'] = scrollbar_y.set


# 窗口类
class Window(ttk.Frame):
    def __init__(self, master=None, **kwargs):
        super().__init__(master, padding=2)
        # 初始化UI
        self.chatShowText = tk.Text(self, width=60, height=20)
        self.chatShowText.grid(sticky=('w', 'e', 'n', 's'), row=0, column=0, columnspan=2)
        self.TextScrollbarY = ttk.Scrollbar(self, orient='vertical')
        self.TextScrollbarY.grid(sticky=('n', 's'), row=0, column=2)
        self.TextScrollbarX = ttk.Scrollbar(self, orient='horizontal')
        self.TextScrollbarX.grid(sticky=('w', 'e'), row=1, column=0, columnspan=2)
        # 设置滚动条
        set_scrollbar(self.chatShowText, self.TextScrollbarX, self.TextScrollbarY)
        self.chatEntry = ttk.Entry(self, width=40)
        self.chat_entry_var = tk.StringVar()
        self.chatEntry['textvariable'] = self.chat_entry_var
        self.chatEntry.grid(row=2, column=0)
        self.sendButton = ttk.Button(self, text="发送", command=self.send_callback)
        self.sendButton.grid(row=2, column=1)

        self.grid(row=0, column=0, sticky=(tk.N, tk.S, tk.E, tk.W))

        self.send_text = ""
        self.local_server_ipaddr = '192.168.31.159'
        self.local_server_port = 10086
        self.target_server_ipaddr = '192.168.31.82'
        self.target_server_port = 10086
        self._init_server()
        self.client_start(self.target_server_ipaddr, self.target_server_port)
        # threading.Thread(target=self.client_listen, args=()).start()

    def send_callback(self, event=None):
        self.send_text = self.chat_entry_var.get()
        self.chat_entry_var.set("")
        self.chatShowText.insert('end', "你说:" + self.send_text + "\n\n")
        send_thread = threading.Thread(target=self.client_send, args=(self.send_text,))
        send_thread.start()

    def client_start(self, ipaddr, port):
        self.tcp_client = socket(AF_INET, SOCK_STREAM)
        self.tcp_client.connect((ipaddr, port))

    def client_send(self, send_text):
        self.tcp_client.send(send_text.encode("utf-8"))

    # def client_listen(self):
    #     while True:
    #         data = self.tcp_client.recv(1024)
    #         self.chatShowText.insert('end', "对方说:" + data.decode("utf-8") + "\n\n")

    def _init_server(self):
        server_thread = threading.Thread(target=self.server_start, args=(self.local_server_ipaddr, self.local_server_port))
        server_thread.start()

    def server_start(self, ipaddr, port):
        back_log = 5
        tcp_server = socket(AF_INET, SOCK_STREAM)
        tcp_server.bind((ipaddr, port))
        tcp_server.listen(back_log)

        while True:
            conn, addr = tcp_server.accept()
            while True:
                data = conn.recv(1024)
                if not data:
                    break
                print("data is %s" % data.decode('utf-8'))
                self.chatShowText.insert('end', "对方说:" + data.decode("utf-8") + "\n\n")
                conn.send(data.upper())

            conn.close()
        tcp_server.close()


if __name__ == '__main__':
    app = Window()
    # 设置窗口标题:
    app.master.title("聊天窗口")
    app.master.minsize(60, 30)
    # 主消息循环:
    app.mainloop()
