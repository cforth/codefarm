import io
import os
from PIL import Image, ImageTk
import tkinter.filedialog as filedialog
from CFTookit.json2gui import *
from CFTookit.CFCrypto import ByteCrypto, StringCrypto


# 窗口类
class Window(ttk.Frame):
    def __init__(self, ui_json, master=None):
        super().__init__(master, padding=2)
        # 从json自动设置UI控件
        create_ui(self, ui_json)
        # 从json自动绑定事件
        create_all_binds(self, ui_json)
        # 存储图片对象，若不存储，图片对象会被垃圾回收无法显示
        self.img = None
        # 存储图片地址列表，用于前后翻页
        self.img_list = []
        # 初始化下拉列表，设置默认值
        self.init_default_crypto_option()
        # 设置gif图片默认运行状态为关闭
        self._gif_running = False
        # 设置图片最大的宽度(gif图片不能缩放)
        self.img_max_width = 1280
        # 设置默认的图片宽度，并设置图片大小滑动条的位置
        self.img_width = 500
        self.__dict__["imgSizeScale"].set(self.img_width * 100 / self.img_max_width)
        # 绑定键盘事件
        self.master.bind("<Key>", self.key_event)
        self.grid(row=0, column=0)

    # 初始化下拉列表，设置默认值
    def init_default_crypto_option(self):
        set_combobox_item(self.__dict__["cryptoOptionCombobox"], "不需解密", True)

    # 根据图片路径，将当前文件夹内所有图片保存在图片列表，用于前后翻页显示
    def set_img_list(self):
        img_path = getattr(self, "imgPath").get()
        img_dir_path = img_path[:img_path.rindex("/") + 1]
        self.img_list = [os.path.join(img_dir_path, img_name) for img_name in os.listdir(img_dir_path)]

    def key_event(self, event=None):
        # 右方向键下一首
        if event.keycode == 39:
            self.next_img_button_callback()
        # 左方向键上一首
        elif event.keycode == 37:
            self.prev_img_button_callback()

    # 选择待显示的图片，填充图片路径，设置图片地址列表
    def file_from_button_callback(self, event=None):
        self.__dict__["imgPath"].set(filedialog.askopenfilename())
        self.set_img_list()

    # 设置密码输入栏中的内容显示或者隐藏
    def password_show_button_callback(self, event=None):
        if self.__dict__["passwordEntry"]["show"] == "*":
            self.__dict__["passwordEntry"]["show"] = ""
        else:
            self.__dict__["passwordEntry"]["show"] = "*"

    # 向前翻页显示图片
    def prev_img_button_callback(self, event=None):
        old_img_path = getattr(self, "imgPath").get()
        index = self.img_list.index(old_img_path)
        if index == 0:
            return
        else:
            new_music_path = self.img_list[index - 1]
            getattr(self, "imgPath").set(new_music_path)
            self.img_show()

    # 向后翻页显示图片
    def next_img_button_callback(self, event=None):
        old_img_path = getattr(self, "imgPath").get()
        index = self.img_list.index(old_img_path)
        if index == len(self.img_list) - 1:
            return
        else:
            new_music_path = self.img_list[index + 1]
            getattr(self, "imgPath").set(new_music_path)
            self.img_show()

    # 设置当前显示的图片的大小，保持横纵比缩放
    def set_img_width(self, event=None):
        self.img_width = int(self.__dict__["imgSizeScale"].get() * self.img_max_width / 100)
        self.img_show()

    # 初始化GIF动图，将GIF动图每一帧保存起来准备显示
    def init_gif(self, img_path):
        self._gif_frames = []
        self._frame_count = 0
        im = Image.open(img_path)
        seq = []
        try:
            while True:
                seq.append(im.copy())
                im.seek(len(seq))  # skip to next frame
        except EOFError:
            pass  # we're done
        try:
            self.delay = im.info['duration']
            # 将默认延时设置为50ms
            if self.delay < 50:
                self.delay = 50
        except KeyError:
            self.delay = 50
        first = seq[0].convert('RGBA')
        self._gif_frames = [ImageTk.PhotoImage(first)]
        temp = seq[0]
        for image in seq[1:]:
            temp.paste(image)
            frame = temp.convert('RGBA')
            self._gif_frames.append(ImageTk.PhotoImage(frame))
            self._frame_count += 1

    # 定时更新GIF动图的每一帧
    def update_gif(self, ind):
        frame = self._gif_frames[ind]
        ind += 1
        if ind >= self._frame_count:
            ind = 0
        self.__dict__["imgLabel"].configure(image=frame)
        self._gif_timer = self.master.after(self.delay, self.update_gif, ind)

    # 启动GIF动图
    def start_gif(self):
        # 设置GIF图片运行标志
        self._gif_running = True
        # 设置更新图片事件
        self._gif_timer = self.master.after(0, self.update_gif, 0)

    # 停止当前的GIF动图
    def stop_gif(self):
        # 停止定时器
        self.master.after_cancel(self._gif_timer)
        self._gif_running = False

    def default_img_show(self, img_path):
        img_data = Image.open(img_path)
        (x, y) = img_data.size
        x_s = self.img_width
        # 调整图片大小时保持横纵比
        y_s = y * x_s // x
        out = img_data.resize((x_s, y_s), Image.ANTIALIAS)
        self.img = ImageTk.PhotoImage(out)
        self.__dict__["imgLabel"].configure(image=self.img)

    def crypto_img_show(self, img_path):
        img_file_like = io.BytesIO(ByteCrypto(self.__dict__["password"].get()).decrypt(img_path))
        self.default_img_show(img_file_like)

    def default_gif_show(self, img_path):
        self.init_gif(img_path)
        self.start_gif()

    def crypto_gif_show(self, img_path):
        img_file_like = io.BytesIO(ByteCrypto(self.__dict__["password"].get()).decrypt(img_path))
        self.default_gif_show(img_file_like)

    # 清空图片显示
    def cancel_img(self):
        # 如果有GIF动图正在运行，则停止这个定时事件
        if self._gif_running:
            self.stop_gif()
        self.__dict__["imgLabel"].config(image='')

    # 根据不同图片类型和解密选项，显示图片
    def img_show(self, event=None):
        self.cancel_img()
        crypto_option = self.__dict__["cryptoOption"].get()
        img_path = self.__dict__["imgPath"].get()
        if not img_path or not os.path.exists(img_path):
            return
        img_name = img_path[img_path.rindex("/") + 1:]
        if crypto_option == "解密文件":
            decrypt_img_name = StringCrypto(self.__dict__["password"].get()).decrypt(img_name)
            if decrypt_img_name.endswith(".gif"):
                self.crypto_gif_show(img_path)
            else:
                self.crypto_img_show(img_path)
        elif crypto_option == "不需解密":
            if img_path.endswith(".gif"):
                self.default_gif_show(img_path)
            else:
                self.default_img_show(img_path)
        elif crypto_option == "解密保名":
            if img_path.endswith(".gif"):
                self.crypto_gif_show(img_path)
            else:
                self.crypto_img_show(img_path)


if __name__ == '__main__':
    app = Window("UI.json")
    # 设置窗口标题:
    app.master.title("图片查看器")
    # 主消息循环:
    app.mainloop()