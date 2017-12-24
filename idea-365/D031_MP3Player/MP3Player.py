import time
import threading
import pygame
import tkinter.filedialog as filedialog
from CFTookit.json2gui import *


# 音乐播放器类，使用pygame实现
class Player(threading.Thread):
    def __init__(self, file_path, master=None):
        threading.Thread.__init__(self)
        # 传入主窗口的指针，用于触发主窗口事件(若有)
        self.master = master
        self.file_path = file_path
        # 用于控制音乐播放与停止
        self.stop_state = False
        # 用于控制音乐的暂停和恢复
        self.pause_state = False

    def run(self):
        try:
            file = self.file_path
            pygame.mixer.init()  # 初始化音频
            track = pygame.mixer.music
            track.load(file)  # 载入音乐文件
            track.play()  # 开始播放
        except Exception as e:
            logging.warning(e)
            if self.master:
                self.master.event_generate("<<MusicError>>", when="tail")

        while True:
            time.sleep(1)
            # 若停止播放或播放结束，则结束这个线程
            if self.stop_state:
                track.stop()  # 停止播放
                return
            elif not track.get_busy():
                if self.master:
                    self.master.event_generate("<<MusicStop>>", when="tail")
                return
            elif not self.stop_state and self.pause_state:
                track.pause()  # 暂停播放
            elif not self.stop_state and not self.pause_state:
                track.unpause()  # 恢复播放


# 窗口类
class Window(tk.Frame):
    def __init__(self, ui_json, master=None):
        super().__init__(master)
        self.player = None
        # 从json自动设置UI控件
        create_ui(self, ui_json)
        # 从json自动绑定事件
        create_all_binds(self, ui_json)
        # 音乐读取错误或播放完毕时，触发自定义事件
        self.bind("<<MusicError>>", self.music_stop)
        self.bind("<<MusicStop>>", self.music_stop)
        # 为顶层窗口绑定关闭事件
        self.master.protocol("WM_DELETE_WINDOW", self.close_event)
        self.grid(row=0, column=0)

    def file_from_button_callback(self, event=None):
        self.__dict__["musicPath"].set(filedialog.askopenfilename())

    def music_start(self, event=None):
        # 设置正在播放的音乐信息
        music_path = self.__dict__["musicPath"].get()
        music_name = music_path[music_path.rindex("/") + 1:]
        self.__dict__["info"].set(music_name)
        self.__dict__["pauseButton"]["text"] = "暂停"

        # 如果已经存在播放器，则停止它
        if self.player:
            self.__dict__["musicProgressBar"].stop()
            self.player.stop_state = True
            time.sleep(1)

        # 中文路径必须编码后才可以
        self.player = Player(self.__dict__["musicPath"].get().encode('utf-8'), self)
        # 启动进度条
        self.__dict__["musicProgressBar"].start()
        self.player.start()

    def music_stop(self, event=None):
        self.__dict__["musicProgressBar"].stop()
        if self.player:
            self.player.stop_state = True
            self.player = None

    def music_pause(self, event=None):
        # 暂停和恢复切换事件
        if self.player and self.player.pause_state:
            self.__dict__["pauseButton"]["text"] = "暂停"
            self.__dict__["musicProgressBar"].start()
            self.player.pause_state = False
        elif self.player and not self.player.pause_state:
            self.__dict__["pauseButton"]["text"] = "恢复"
            self.__dict__["musicProgressBar"].stop()
            self.player.pause_state = True

    # 在顶层窗口关闭时，先结束音乐播放线程
    def close_event(self, event=None):
        self.music_stop()
        self.master.destroy()


if __name__ == '__main__':
    app = Window("UI.json")
    # 设置窗口标题:
    app.master.title("音乐播放器")
    # 主消息循环:
    app.mainloop()
