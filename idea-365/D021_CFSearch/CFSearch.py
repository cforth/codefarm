import os


class CoolFileSearch(object):
    movie_filter = ['.mp4', '.MP4', '.avi', '.AVI', '.wmv', '.WMV',
                    '.rmvb', '.RMVB', '.mov', '.MOV', '.mkv', '.MKV']
    picture_filter = ['.bmp', '.BMP', '.gif', '.GIF', '.jpeg', '.JGEG',
                      '.jpg', '.JPG', '.png', '.PNG']
    data_filter = ['.zip', '.ZIP', '.rar', '.RAR', '.7z', '.7Z']
    doc_filter = ['.doc', '.xls', '.ppt', '.pdf']

    # 初始化时设置好过滤器
    def __init__(self, the_filter):
        self.the_filter = the_filter

    # 搜索过滤列表内的后缀名文件，返回一个生成器
    def search(self, dir_path):
        for path, subdir, files in os.walk(dir_path):
            for f in files:
                if '.' in f and f[f.rindex('.'):] in self.the_filter:
                    file_path = os.path.abspath(path)
                    yield file_path + '\\' + f
