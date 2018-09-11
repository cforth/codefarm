import tkinter as tk
import tkinter.ttk as ttk
import time
from threading import Thread


class ProgressBar(ttk.Frame):
    def __init__(self, progress_current, progress_total, progress_var, master=None):
        super().__init__(master, padding=2)
        self.progress_var = tk.DoubleVar()
        self.progress_current_label_var = tk.StringVar()
        self.progress_total_label_var = tk.StringVar()
        self.progress_var.set(progress_var)
        self.progress_current_label_var.set(progress_current)
        self.progress_total_label_var.set(progress_total)
        self.progressCurrentLabel = ttk.Label(self, textvariable=self.progress_current_label_var)
        self.progressBar = ttk.Progressbar(self, orient='horizontal', mode='determinate', value=0)
        self.progressBar['variable'] = self.progress_var
        self.progressTotalLabel = ttk.Label(self, textvariable=self.progress_total_label_var)
        pad_w_e = dict(sticky=(tk.W, tk.E), padx="0.5m", pady="0.5m")
        self.progressCurrentLabel.grid(row=0, column=0, **pad_w_e)
        self.progressBar.grid(row=0, column=1, **pad_w_e)
        self.progressTotalLabel.grid(row=0, column=2, **pad_w_e)
        self.grid(row=0, column=0, sticky=(tk.N, tk.S, tk.E, tk.W))

    def set_status(self, progress_current, progress_total, progress_var):
        self.progress_var.set(progress_var)
        self.progress_current_label_var.set(progress_current)
        self.progress_total_label_var.set(progress_total)


class Window(ttk.Frame):
    def __init__(self, master=None):
        super().__init__(master, padding=2)
        self.bar = ProgressBar("0%", "100%", 0.0, master=self)
        self.button = ttk.Button(self, text="开始", command=self.do)
        self.bar.pack()
        self.button.pack()
        self.pack()

    def update_bar(self):
        for x in range(100):
            self.bar.set_status(str(x) + "%", "100%", x)
            time.sleep(1)

    def do(self):
        xxx = Thread(target=self.update_bar, args=())
        xxx.start()


if __name__ == '__main__':
    app = Window()
    # 设置窗口标题:
    app.master.title("进度条")
    # 主消息循环:
    app.mainloop()
