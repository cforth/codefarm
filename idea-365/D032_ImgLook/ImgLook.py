import io
import zipfile
import os
from PIL import Image, ImageTk
import tkinter.filedialog as filedialog
from CFTookit.json2gui import *


# 窗口类
class Window(ttk.Frame):
    def __init__(self, ui_json, master=None):
        super().__init__(master, padding=2)
        # 从json自动设置UI控件
        create_ui(self, ui_json)
        # 从json自动绑定事件
        create_all_binds(self, ui_json)
        # 存储图片对象
        self.img = None
        # 存储图片地址列表
        self.img_list = []
        self.grid(row=0, column=0)

    def set_img_list(self):
        img_path = getattr(self, "imgPath").get()
        img_dir_path = img_path[:img_path.rindex("/") + 1]
        self.img_list = [os.path.join(img_dir_path, img_name) for img_name in os.listdir(img_dir_path)]

    def file_from_button_callback(self, event=None):
        self.__dict__["imgPath"].set(filedialog.askopenfilename())
        self.set_img_list()

    def prev_img_button_callback(self, event=None):
        old_img_path = getattr(self, "imgPath").get()
        index = self.img_list.index(old_img_path)
        if index == 0:
            return
        else:
            new_music_path = self.img_list[index - 1]
            getattr(self, "imgPath").set(new_music_path)
            self.img_show()

    def next_img_button_callback(self, event=None):
        old_img_path = getattr(self, "imgPath").get()
        index = self.img_list.index(old_img_path)
        if index == len(self.img_list) - 1:
            return
        else:
            new_music_path = self.img_list[index + 1]
            getattr(self, "imgPath").set(new_music_path)
            self.img_show()

    def img_show(self, event=None):
        img_data = Image.open(self.__dict__["imgPath"].get())
        (x, y) = img_data.size
        x_s = 500
        y_s = y * x_s // x
        out = img_data.resize((x_s, y_s), Image.ANTIALIAS)
        self.img = ImageTk.PhotoImage(out)
        self.__dict__["imgLabel"].configure(image=self.img)


if __name__ == '__main__':
    app = Window("UI.json")
    # 设置窗口标题:
    app.master.title("图片查看器")
    # 主消息循环:
    app.mainloop()
