import subprocess
import os
import tkinter.filedialog as filedialog
from json2gui import *


# 需要下载ffmpeg才可以使用,windows平台
def intercept_video(ffmpeg_path, media_path, video_start_time, intercept_time, video_save_dir):
    ffmpeg_abspath = r'"' + os.path.abspath(ffmpeg_path).replace('/', '\\') + r'"'
    media_abspath = r'"' + os.path.abspath(media_path).replace('/', '\\') + r'"'
    video_save_absdir = r'"' + os.path.abspath(video_save_dir).replace('/', '\\') + r'"'
    cmd = ffmpeg_abspath + ' -y -i ' + media_abspath + ' -ss ' + video_start_time + ' -t ' + intercept_time + \
          ' -acodec copy -vcodec copy -async 1 ' + video_save_absdir
    subprocess.call(cmd, shell=True)


# 窗口类
class Window(ttk.Frame):
    def __init__(self, ui_json, master=None):
        super().__init__(master)
        # 从json自动设置UI控件
        create_ui(self, ui_json)
        # 从json自动绑定事件
        create_all_binds(self, ui_json)
        self.master.columnconfigure(0, weight=1)
        self.master.rowconfigure(0, weight=1)
        self.grid(row=0, column=0, sticky=(tk.N, tk.S, tk.E, tk.W))
        self.columnconfigure(1, weight=1)

    def intercept_video_button_callback(self, event=None):
        intercept_video(self.ffmpeg_path.get(), self.current_video_path.get(),
                        self.video_start_time.get(), self.intercept_time.get(),
                        os.path.join(self.video_save_dir_path.get(), self.video_save_name.get()))

    def ffmpeg_from_button_callback(self, event=None):
        ffmpeg_path = filedialog.askopenfilename()
        if ffmpeg_path:
            self.ffmpeg_path.set(ffmpeg_path)

    def file_from_button_callback(self, event=None):
        video_path = filedialog.askopenfilename()
        if video_path:
            self.current_video_path.set(video_path)

    def file_to_button_callback(self, event=None):
        video_save_dir_path = filedialog.askdirectory()
        if video_save_dir_path:
            self.video_save_dir_path.set(video_save_dir_path)


if __name__ == '__main__':
    app = Window("FFmpegToolUI.json")
    # 设置窗口标题:
    app.master.title("FFmpeg视频截取工具")
    # 主消息循环:
    app.mainloop()
