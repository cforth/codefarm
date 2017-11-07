import tkinter as tk
import tkinter.ttk as ttk
import tkinter.filedialog as filedialog
import base64
import hashlib
import os
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad


# 将文件加密后解密后返回二进制数据
class ByteCrypto:
    def __init__(self, password):
        # 将密码转为md5值作为密钥
        md5 = hashlib.md5()
        md5.update(password.encode('utf-8'))
        self.key = md5.digest()
        # AES的ECB模式，数据的长度必须为16节的倍数
        self.multiple_of_byte = 16
        # 使用ECB模式进行加密解密
        self.cipher = AES.new(self.key, AES.MODE_ECB)
        # 设置加密解密时分块读取10240KB
        self.read_kb = 10240

    @staticmethod
    def handle(file_path, block_size, data_handle_func, data_end_handle_func):
        if not os.path.exists(file_path):
            raise ValueError('Input file path not exists: %s ', file_path)

        file_len = os.path.getsize(file_path)
        res_data = bytes()
        with open(file_path, 'rb') as f:
            read = 0
            while True:
                data = f.read(block_size)
                if not data:
                    break
                read += len(data)
                if read == file_len:
                    data = data_end_handle_func(data)
                else:
                    data = data_handle_func(data)
                res_data = res_data + data
        return res_data

    # 加密文件
    def encrypt(self, file_path):
        block_size = self.read_kb * 1024
        data_handle_func = self.cipher.encrypt
        # 读取到文件尾部时，执行尾部补位操作后加密
        data_end_handle_func = lambda d: self.cipher.encrypt(pad(d, self.multiple_of_byte))
        return ByteCrypto.handle(file_path, block_size, data_handle_func, data_end_handle_func)

    # 解密文件
    def decrypt(self, file_path):
        block_size = self.read_kb * 1024
        data_handle_func = self.cipher.decrypt
        # 读取到文件尾部时，执行解密后尾部去除补位
        data_end_handle_func = lambda d: unpad(self.cipher.decrypt(d), self.multiple_of_byte)
        return ByteCrypto.handle(file_path, block_size, data_handle_func, data_end_handle_func)


# 字符串加密解密类
class StringCrypto(object):
    def __init__(self, password):
        # 将密码转为md5值作为密钥
        md5 = hashlib.md5()
        md5.update(password.encode('utf-8'))
        self.key = md5.digest()
        # AES的ECB模式，数据的长度必须为16节的倍数
        self.multiple_of_byte = 16
        # 使用ECB模式进行加密解密
        self.cipher = AES.new(self.key, AES.MODE_ECB)

    # 加密字符串
    # 将字符串转为字节串进行AES加密，
    # 再将加密后的字节串转为16进制字符串，
    # 再通过base64模块编码
    def encrypt(self, string):
        pad_byte_string = pad(string.encode('utf-8'), self.multiple_of_byte)
        encrypt_byte_string = self.cipher.encrypt(pad_byte_string)
        encrypt_string = base64.urlsafe_b64encode(encrypt_byte_string).decode('ascii')
        return encrypt_string

    # 解密字符串
    # 步骤与加密相反
    def decrypt(self, encrypt_string):
        encrypt_byte_string = base64.urlsafe_b64decode(bytes(map(ord, encrypt_string)))
        pad_byte_string = self.cipher.decrypt(encrypt_byte_string)
        string = unpad(pad_byte_string, self.multiple_of_byte).decode('utf-8')
        return string


# 将加密后的PNG/GIF图片在内存中解密后显示出来
# 注意本演示窗口类对于高分辨率图片会显示不全，是因为Tkinter的PhotoImage部件的缺陷
class Window(ttk.Frame):
    def __init__(self, master=None):
        super().__init__(master, padding=2)
        self.master = master
        # 存储PNG图片
        self.img = None
        # 存储GIF动图的每一帧
        self._gif_frames = []
        # 当前GIF动图正在显示的帧编号
        self._frame_count = 0
        # 保存定时顺序显示GIF每一帧事件
        self._gif_timer = None
        # 设置GIF动图运行的标志
        self._gif_running = False
        # 存储当前图片所在的文件夹内的文件列表，用来点击下一个图片
        self._img_list = []
        # 主要窗口部件
        self.passwordEntry = ttk.Entry(self, width=100, show="*")
        self.passwordShowButton = ttk.Button(self, text="密码", width=10, command=self.password_show)
        self.textFromEntry = ttk.Entry(self, width=100)
        self.fileFromChooseButton = ttk.Button(self, text="来源", width=10, command=self.file_from_choose)
        self.showButton = ttk.Button(self, text="Go", width=10, command=self.show_img)
        self.nextFileButton = ttk.Button(self, text=" > ", width=10, command=self.next_img)
        self.priorFileButton = ttk.Button(self, text=" < ", width=10, command=self.prior_img)
        # 使用Label部件显示解密后的图片
        self.label = ttk.Label(self)
        # 将窗口部件布局
        pad_w_e = dict(sticky=(tk.W, tk.E), padx="0.5m", pady="0.5m")
        pad_n_s = dict(sticky=(tk.N, tk.S), padx="0.5m", pady="0.5m")
        pad_n_s_e_w = dict(sticky=(tk.N, tk.S, tk.E, tk.W), padx="0.5m", pady="0.5m")
        self.passwordEntry.grid(row=0, column=1, **pad_w_e)
        self.passwordShowButton.grid(row=0, column=0, **pad_w_e)
        self.textFromEntry.grid(row=1, column=1, **pad_w_e)
        self.fileFromChooseButton.grid(row=1, column=0, **pad_w_e)
        self.showButton.grid(row=0, column=2, rowspan=2, **pad_n_s_e_w)
        self.priorFileButton.grid(row=2, column=0, **pad_n_s)
        self.nextFileButton.grid(row=2, column=2, **pad_n_s)
        self.label.grid(row=2, column=1, **pad_n_s_e_w)
        self.grid(row=0, column=0, **pad_n_s_e_w)

    # 选择需要显示的加密图片
    def file_from_choose(self):
        file_path = filedialog.askopenfilename()
        # 选择输入文件路径后，在文件浏览器中选中的文件
        self.textFromEntry.delete(0, len(self.textFromEntry.get()))
        self.textFromEntry.insert(0, file_path)

    # 显隐密码
    def password_show(self):
        if self.passwordEntry["show"] == "*":
            self.passwordEntry["show"] = ""
        else:
            self.passwordEntry["show"] = "*"

    # 初始化GIF动图，将GIF动图每一帧保存起来准备显示
    def init_gif(self, encode_str):
        self._gif_frames = []
        self._frame_count = 0
        while True:
            try:
                photo = tk.PhotoImage(data=encode_str, format='gif -index %i' % (self._frame_count))
                self._gif_frames.append(photo)
                self._frame_count += 1
            except tk.TclError:
                break

    # 定时更新GIF动图的每一帧
    def update_gif(self, ind):
        frame = self._gif_frames[ind]
        ind += 1
        if ind >= self._frame_count:
            ind = 0
        self.label.configure(image=frame)
        self._gif_timer = self.master.after(100, self.update_gif, ind)

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

    # 清空图片显示
    def cancel_img(self):
        # 如果有GIF动图正在运行，则停止这个定时事件
        if self._gif_running:
            self.stop_gif()
        self.master.title('')
        self.label.config(image='')

    # 点击按钮解密并显示图片
    def show_img(self):
        password = self.passwordEntry.get()
        img_path = self.textFromEntry.get()
        img_name = os.path.split(img_path)[1]

        try:
            # 解密文件名
            title_str = StringCrypto(password).decrypt(img_name)
            # 解密图片后转为Base64字符串保存
            encode_str = base64.b64encode(ByteCrypto(password).decrypt(img_path))
        except Exception as error:
            print(error)
            self.cancel_img()
            self.label.config(text='Decrypt File: password error or image format error !')
            return

        # 清空原来的图片显示
        self.cancel_img()
        # 设置窗口标题
        self.master.title(title_str)
        # 获取图片后缀名
        ext = os.path.splitext(title_str)[1].lower()

        if ext == '.png':
            # 注意使用base64字符串时，需要指定为data参数
            self.img = tk.PhotoImage(data=encode_str)
            self.label.config(image=self.img)
        elif ext == '.gif':
            self.init_gif(encode_str)
            self.start_gif()
        else:
            self.label.config(text='Not support this image format: %s' % ext)

    # 根据方向设置图片地址
    def set_direction_path(self, direction):
        img_path = self.textFromEntry.get()
        img_name = os.path.split(os.path.realpath(img_path))[1]
        dir_path = os.path.split(os.path.realpath(img_path))[0]
        img_name_list = self.set_img_list(dir_path)
        length = len(img_name_list)
        index = img_name_list.index(img_name)
        if direction == 'next':
            if index < length - 1:
                next_img = img_name_list[index + 1]
                self.textFromEntry.delete(0, len(self.textFromEntry.get()))
                self.textFromEntry.insert(0, os.path.join(dir_path, next_img))
        elif direction == 'prior':
            if index > 0:
                prior_img = img_name_list[index - 1]
                self.textFromEntry.delete(0, len(self.textFromEntry.get()))
                self.textFromEntry.insert(0, os.path.join(dir_path, prior_img))

    # 返回当前图片所在的文件夹的所有图片列表
    def set_img_list(self, dir_path):
        img_name_list = []
        for path, subdir, files in os.walk(dir_path):
            for f in files:
                img_name_list.append(f)
        return img_name_list

    # 点击下一个按钮解密并显示文件夹内下一个图片
    def next_img(self):
        img_path = self.textFromEntry.get()
        if img_path and os.path.exists(img_path):
            self.set_direction_path('next')
            self.show_img()

    # 点击上一个按钮解密并显示文件夹内上一个图片
    def prior_img(self):
        img_path = self.textFromEntry.get()
        if img_path and os.path.exists(img_path):
            self.set_direction_path('prior')
            self.show_img()


def main():
    root = tk.Tk()
    Window(master=root)
    root.title("加密PNG/GIF图片显示器")
    root.mainloop()


if __name__ == '__main__':
    main()
