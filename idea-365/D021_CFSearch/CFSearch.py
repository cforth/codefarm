import os


class FileSearch(object):
    MOVIE = ['mp4', 'avi', 'wmv', 'rmvb', 'mov', 'mkv']
    PIC = ['bmp', 'gif', 'jpeg', 'jpg', 'png']
    DATA = ['zip', 'rar', '7z']
    DOC = ['doc', 'xls', 'ppt', 'pdf', 'txt']

    # 初始化时设置好过滤器
    def __init__(self, the_filter):
        capital_filter = [x.upper() for x in the_filter]
        self.the_filter = the_filter + capital_filter
        print(self.the_filter)

    # 搜索过滤列表内的后缀名文件，返回一个生成器
    def search(self, dir_path):
        for path, subdir, files in os.walk(dir_path):
            for f in files:
                if '.' in f and f[f.rindex('.')+1:] in self.the_filter:
                    file_path = os.path.abspath(path)
                    yield os.path.join(file_path, f)
