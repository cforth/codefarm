import time
import threading
import pygame
import os
import tkinter.filedialog as filedialog
from CFTookit.json2gui import *


# 音乐播放器类，使用pygame实现
class Player(threading.Thread):
    def __init__(self, file_path, volume=1.0, master=None):
        threading.Thread.__init__(self)
        # 传入主窗口的指针，用于触发主窗口事件(若有)
        self.master = master
        self.file_path = file_path
        # 用于控制音乐播放与停止
        self.stop_state = False
        # 用于控制音乐的暂停和恢复
        self.pause_state = False
        # 控制默认音量
        self.volume = volume
        # 初始化mixer
        pygame.mixer.init()  # 初始化音频
        self.track = pygame.mixer.music

    def set_volume(self, volume):
        self.volume = volume
        self.track.set_volume(self.volume)

    def get_volume(self):
        return self.volume

    def run(self):
        try:
            file = self.file_path
            self.track.load(file)  # 载入音乐文件
            self.track.set_volume(self.volume)  # 设置音量
            self.track.play()  # 开始播放
        except Exception as e:
            logging.warning(e)
            if self.master:
                self.master.event_generate("<<MusicError>>", when="tail")

        while True:
            time.sleep(1)
            # 若停止播放或播放结束，则结束这个线程
            if self.stop_state:
                self.track.stop()  # 停止播放
                return
            elif not self.track.get_busy():
                if self.master:
                    self.master.event_generate("<<CouldMusicStop>>", when="tail")
                return
            elif not self.stop_state and self.pause_state:
                self.track.pause()  # 暂停播放
            elif not self.stop_state and not self.pause_state:
                self.track.unpause()  # 恢复播放


# 窗口类
class Window(ttk.Frame):
    def __init__(self, ui_json, master=None):
        super().__init__(master, padding=2)
        # 初始化音乐播放器对象的引用
        self.player = None
        # 从json自动设置UI控件
        create_ui(self, ui_json)
        # 从json自动绑定事件
        create_all_binds(self, ui_json)
        # 顶层窗口事件绑定
        self.bind_window_event()
        # 初始化音乐循环下拉列表，设置默认的音量值
        self.init_default_play_option()
        # 初始化音乐播放列表窗口
        self.init_music_list_window()
        # 初始化音乐播放列表
        self.music_play_list = []
        self.grid(row=0, column=0)

    # 设置下拉列表框的内容
    @staticmethod
    def set_combobox_item(combobox, text, fuzzy=False):
        for index, value in enumerate(combobox.cget("values")):
            if (fuzzy and text in value) or (value == text):
                combobox.current(index)
                return
        combobox.current(0 if len(combobox.cget("values")) else -1)

    # 初始化音乐循环下拉列表，设置默认的音量值
    def init_default_play_option(self):
        Window.set_combobox_item(self.__dict__["playOptionCombobox"], "单曲播放", True)
        self.__dict__["musicVolumeScale"].set(60)

    # 顶层窗口事件绑定
    def bind_window_event(self):
        # 音乐读取错误或播放完毕时，触发自定义事件
        self.bind("<<MusicError>>", self.music_stop)
        self.bind("<<MusicStop>>", self.music_stop)
        self.bind("<<CouldMusicStop>>", self.could_music_stop)
        # 绑定关闭事件
        self.master.protocol("WM_DELETE_WINDOW", self.close_event)
        # 绑定键盘事件
        self.master.bind("<Key>", self.key_event)

    def file_from_button_callback(self, event=None):
        self.__dict__["musicPath"].set(filedialog.askopenfilename())
        if self.__dict__["musicPath"].get():
            # 在音乐播放列表中填充内容
            self.set_music_list_window()
        else:
            self.clear_music_list_window()
        # 获取音乐文件夹路径
        music_path = self.__dict__["musicPath"].get()
        if os.path.exists(music_path):
            music_dir_path = music_path[:music_path.rindex("/") + 1]
            music_play_list = []
            for m in os.listdir(music_dir_path):
                if m.endswith(".MP3") or m.endswith(".mp3"):
                    music_play_list.append(os.path.join(music_dir_path, m))
            self.music_play_list = music_play_list

    def key_event(self, event=None):
        # 摁空格键暂停或恢复音乐播放
        if event.char == " ":
            self.music_pause()
        # 右方向键下一首
        elif event.keycode == 39:
            self.next_music()
        # 左方向键上一首
        elif event.keycode == 37:
            self.prev_music()

    # 在顶层窗口关闭时，先结束音乐播放线程
    def close_event(self, event=None):
        self.music_stop()
        self.master.destroy()

    def music_start(self, event=None):
        # 设置正在播放的音乐信息
        music_path = self.__dict__["musicPath"].get()
        # 如果不存在这个路径，则退出播放
        if not music_path or not os.path.exists(music_path):
            self.__dict__["musicPath"].set("")
            return

        music_name = music_path[music_path.rindex("/") + 1:]
        self.__dict__["info"].set(music_name)
        self.__dict__["pauseButton"]["text"] = "暂停"

        # 如果已经存在播放器，则停止它
        if self.player:
            self.__dict__["musicProgressBar"].stop()
            self.player.stop_state = True
            time.sleep(1)

        # 中文路径必须编码后才可以
        now_volume = self.__dict__["musicVolumeScale"].get() / 100.0
        self.player = Player(self.__dict__["musicPath"].get().encode('utf-8'), now_volume, self)
        # 启动进度条
        self.__dict__["musicProgressBar"].start()
        self.player.start()

    def next_music(self, event=None):
        old_music_path = self.__dict__["musicPath"].get()
        index = self.music_play_list.index(old_music_path)
        if not self.music_play_list or index == len(self.music_play_list) - 1:
            return
        else:
            new_music_path = self.music_play_list[index + 1]
            self.__dict__["musicPath"].set(new_music_path)
            self.music_start()

    def prev_music(self, event=None):
        old_music_path = self.__dict__["musicPath"].get()
        index = self.music_play_list.index(old_music_path)
        if not self.music_play_list or index == 0:
            return
        else:
            new_music_path = self.music_play_list[index - 1]
            self.__dict__["musicPath"].set(new_music_path)
            self.music_start()

    def music_stop(self, event=None):
        self.__dict__["musicProgressBar"].stop()
        if self.player:
            self.player.stop_state = True
            self.player = None

    def could_music_stop(self, event=None):
        self.music_stop()
        if self.__dict__["playOption"].get() == "顺序播放":
            self.next_music()

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

    # 设置播放音乐的音量
    def set_music_volume(self, event=None):
        # 获取Player类需要的音量值，在0到1之间
        now_volume = self.__dict__["musicVolumeScale"].get() / 100.0
        if self.player:
            self.player.set_volume(now_volume)

    # 初始化音乐播放列表窗口
    def init_music_list_window(self):
        # 找到musicListTreeview控件和的musicListVbar控件的引用
        music_list = getattr(self, "musicListTreeview")
        music_list_vbar = getattr(self, "musicListVbar")
        music_list_vbar["command"] = music_list.yview
        # 定义树形结构与滚动条
        music_list.configure(yscrollcommand=music_list_vbar.set)
        # 表格的标题
        music_list.column("a", width=50, anchor="center")
        music_list.column("b", width=700, anchor="w")
        music_list.heading("a", text="序号")
        music_list.heading("b", text="音乐名称")

    # 设置音乐播放列表
    def set_music_list_window(self):
        music_path = self.__dict__["musicPath"].get()
        # 如果不存在这个路径，则退出播放
        if not music_path or not os.path.exists(music_path):
            self.__dict__["musicPath"].set("")
            return
        music_name = music_path[:music_path.rindex("/")]
        self.insert_music_list(music_name)

    # 清空表格
    def clear_music_list_window(self):
        # 找到musicListTreeview控件的引用
        music_list = getattr(self, "musicListTreeview")
        # 删除原节点
        for _ in map(music_list.delete, music_list.get_children("")):
            pass
        self.music_play_list = []

    # 表格内容插入
    def insert_music_list(self, dir_path):
        self.clear_music_list_window()
        # 找到musicListTreeview控件的引用
        music_list = getattr(self, "musicListTreeview")
        # 获取音乐播放列表
        music_name_list = [f for f in os.listdir(dir_path) if f.endswith(".MP3") or f.endswith(".mp3")]
        # 更新插入新节点
        for i in range(0, len(music_name_list)):
            music_list.insert("", "end", values=(i + 1, music_name_list[i]))

    # 音乐列表双击事件处理
    def double_click_music_callback(self, event=None):
        if not event.widget.item(event.widget.selection(), 'values'):
            return
        new_music_name = event.widget.item(event.widget.selection(), 'values')[1]
        old_music_path = self.__dict__["musicPath"].get()
        new_music_path = os.path.join(old_music_path[:old_music_path.rindex("/") + 1], new_music_name)
        self.__dict__["musicPath"].set(new_music_path)
        self.music_start()


if __name__ == '__main__':
    app = Window("UI.json")
    # 设置窗口标题:
    app.master.title("音乐播放器")
    # 主消息循环:
    app.mainloop()
