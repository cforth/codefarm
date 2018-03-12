import tkinter as tk
import tkinter.ttk as ttk
from PIL import Image, ImageTk
import tkinter.filedialog as filedialog


def get_screen_size(window):
    return window.winfo_screenwidth(), window.winfo_screenheight()


def get_window_size(window):
    return window.winfo_reqwidth(), window.winfo_reqheight()


def get_window_current_size(window):
    return window.winfo_width(), window.winfo_height()


def center_window(root, width, height):
    screenwidth = root.winfo_screenwidth()
    screenheight = root.winfo_screenheight()
    size = '%dx%d+%d+%d' % (width, height, (screenwidth - width) / 2, (screenheight - height) / 2)
    print(size)
    root.geometry(size)


# 窗口类
class CFCanvas(ttk.Frame):
    def __init__(self, master=None):
        super().__init__(master, padding=2)
        self.img_data = None
        self.img = None
        self.img_position_x = 0
        self.img_position_y = 0
        self.canvas_img_id = None
        self.screenwidth, self.screenheight = get_screen_size(self)
        self.canvas_width, self.canvas_height = 500, 500
        self.img_width, self.img_height = 500, 500

        self.canvas = tk.Canvas(self, width=self.canvas_width, height=self.canvas_height,
                                scrollregion=(0, 0, self.img_width, self.img_height))
        self.ysb = tk.Scrollbar(self, orient='vertical', command=self.canvas.yview)
        self.xsb = tk.Scrollbar(self, orient='horizontal', command=self.canvas.xview)
        self.canvas['xscrollcommand'] = self.xsb.set
        self.canvas['yscrollcommand'] = self.ysb.set

        self.canvas.grid(row=0, column=0, sticky=tk.N + tk.S + tk.E + tk.W)
        self.ysb.grid(row=0, column=1, sticky=tk.N + tk.S)
        self.xsb.grid(row=1, column=0, sticky=tk.E + tk.W)
        self.grid(row=0, column=0, sticky=tk.N + tk.S + tk.E + tk.W)
        self.columnconfigure(0, weight=1)
        self.rowconfigure(0, weight=1)

    def img_show(self, img_path):
        self.img_data = Image.open(img_path)
        self.img_width, self.img_height = self.img_data.size
        self.img_adjust_size(self.img_width, self.img_height)

    def img_adjust_size(self, width, height):
        canvas_width, canvas_height = get_window_current_size(self.canvas)
        self.img_width, self.img_height = int(width), int(height)
        if self.img_width > canvas_width:
            if self.img_width <= self.screenwidth - 50:
                self.canvas.configure(width=self.img_width)
            else:
                self.canvas.configure(width=self.screenwidth)
        if self.img_height > canvas_height:
            if self.img_height <= self.screenheight - 50:
                self.canvas.configure(height=self.img_height)
            else:
                self.canvas.configure(height=self.screenheight)

        self.canvas.configure(scrollregion=(0, 0, self.img_width, self.img_height))
        self.img = ImageTk.PhotoImage(self.img_data.resize((self.img_width, self.img_height), Image.ANTIALIAS))
        self.img_center()

    def img_center(self, event=None):
        canvas_width, canvas_height = get_window_current_size(self.canvas)
        if canvas_width == 1 and canvas_height == 1:
            return
        else:
            self.canvas_width, self.canvas_height = canvas_width, canvas_height

            if self.img_width > self.canvas_width:
                self.img_position_x = 0
            else:
                self.img_position_x = (self.canvas_width - self.img_width) / 2

            if self.img_height > self.canvas_height:
                self.img_position_y = 0
            else:
                self.img_position_y = (self.canvas_height - self.img_height) / 2

            if self.canvas_img_id:
                self.canvas.delete(self.canvas_img_id)
            if self.img:
                self.canvas_img_id = self.canvas.create_image(self.img_position_x, self.img_position_y,
                                                              anchor=tk.NW, image=self.img)


class Window(ttk.Frame):
    def __init__(self, master=None):
        super().__init__(master, padding=2)
        self.master = master
        self.file_path = ""
        self.increase_button = ttk.Button(self, text="放大", command=self.increase)
        self.decrease_button = ttk.Button(self, text="缩小", command=self.decrease)
        self.show_button = ttk.Button(self, text="选择", command=self.set_img_path)
        self.increase_button.grid(row=0, column=0, sticky=tk.W)
        self.decrease_button.grid(row=0, column=1, sticky=tk.W)
        self.show_button.grid(row=0, column=2, sticky=tk.W)
        self.img_canvas = CFCanvas(self)
        self.img_canvas.grid(row=1, column=0, columnspan=3, sticky=tk.N + tk.S + tk.E + tk.W)
        self.grid(row=0, column=0, sticky=tk.N + tk.S + tk.E + tk.W)
        self.master.columnconfigure(0, weight=1)
        self.master.rowconfigure(0, weight=1)
        self.columnconfigure(0, weight=1)
        self.rowconfigure(1, weight=1)
        self.master.bind("<Configure>", self.img_canvas.img_center)

    def set_img_path(self, event=None):
        self.file_path = filedialog.askopenfilename()
        self.img_canvas.img_show(self.file_path)

    def increase(self, event=None):
        if self.img_canvas.img_width > 5000 or self.img_canvas.img_height > 5000:
            return
        else:
            self.img_canvas.img_adjust_size(self.img_canvas.img_width * 1.2, self.img_canvas.img_height * 1.2)

    def decrease(self, event=None):
        if self.img_canvas.img_width < 10 or self.img_canvas.img_height < 10:
            return
        else:
            self.img_canvas.img_adjust_size(self.img_canvas.img_width * 0.8, self.img_canvas.img_height * 0.8)


if __name__ == '__main__':
    master = tk.Tk()
    app = Window(master)
    # 主消息循环:
    master.mainloop()
