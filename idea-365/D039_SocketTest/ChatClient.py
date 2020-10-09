import tkinter.ttk as ttk
import tkinter as tk
import logging
from socket import *
import tkinter.messagebox
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
        self.chatEntry.grid(row=2, column=0, sticky=(tk.E, tk.W))
        self.sendButton = ttk.Button(self, text="发送", command=self.send_callback)
        self.sendButton.grid(row=2, column=1)

        self.grid(row=0, column=0, sticky=(tk.N, tk.S, tk.E, tk.W))
        self.columnconfigure(0, weight=1)
        self.rowconfigure(0, weight=1)
        self.master.columnconfigure(0, weight=1)
        self.master.rowconfigure(0, weight=1)

        # 绑定最顶层窗口的关闭按钮事件
        self.master.protocol("WM_DELETE_WINDOW", self.quit_program)

        self.send_text = ""
        self.local_server_ipaddr = '127.0.0.1'
        self.local_server_port = 10086
        self.target_server_ipaddr = '127.0.0.1'
        self.target_server_port = 10099
        self._init_server()
        self.tcp_client = None
        self.tcp_server = None
        self.conn = None

    def send_callback(self, event=None):
        self.send_text = self.chat_entry_var.get()
        self.chat_entry_var.set("")
        self.chatShowText.insert('end', "你说:" + self.send_text + "\n\n")
        self.chatShowText.see(self.chatShowText.index('end'))
        if not self.tcp_client:
            try:
                self.tcp_client = socket(AF_INET, SOCK_STREAM)
                self.tcp_client.connect((self.target_server_ipaddr, self.target_server_port))
            except Exception as e:
                print(e)
                self.tcp_client.close()
                self.tcp_client = None
                self.send_text = ""
                self.chatShowText.insert('end', "消息未送达，对方已离线！\n\n")
        if self.send_text:
            send_thread = threading.Thread(target=self.client_send, args=(self.send_text,))
            send_thread.start()

    def client_send(self, send_text):
        try:
            self.tcp_client.send(send_text.encode("utf-8"))
        except Exception as e:
            print(e)
            self.chatShowText.insert('end', "消息未送达，对方已离线！\n\n")
            self.tcp_client.close()
            self.tcp_client = None

    def _init_server(self):
        server_thread = threading.Thread(target=self.server_start, args=(self.local_server_ipaddr, self.local_server_port))
        server_thread.start()

    def server_start(self, ipaddr, port):
        back_log = 5
        self.tcp_server = socket(AF_INET, SOCK_STREAM)
        self.tcp_server.bind((ipaddr, port))
        self.tcp_server.listen(back_log)

        while True:
            self.conn, addr = self.tcp_server.accept()
            while True:
                data = self.conn.recv(1024)
                if not data:
                    break
                print("data is %s" % data.decode('utf-8'))
                self.chatShowText.insert('end', "对方说:" + data.decode("utf-8") + "\n\n")
                self.chatShowText.see(self.chatShowText.index('end'))
                # conn.send(data.upper())

            self.conn.close()
        self.tcp_server.close()

    def quit_program(self):
        quit_result = tk.messagebox.askokcancel('提示', '真的要退出吗？')
        if quit_result:
            if self.tcp_server:
                self.tcp_server.close()
            if self.conn:
                self.conn.close()
            if self.tcp_client:
                self.tcp_client.close()
            self.master.quit()


if __name__ == '__main__':
    app = Window()
    # 设置窗口标题:
    app.master.title("聊天窗口")
    app.master.minsize(60, 30)
    # 主消息循环:
    app.mainloop()
