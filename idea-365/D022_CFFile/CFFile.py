class File(object):
    def __init__(self, path, size):
        self.path = path
        self.tell_pos = 0
        self.size = size
        self.gen_file()

    def gen_file(self):
        with open(self.path, 'w') as f:
            f.seek(self.size-1)
            f.write('\x00')

    def write(self, data, mode='r+'):
        if len(data) + self.tell_pos > self.size:
            print('error')
            return
        with open(self.path, mode) as f:
            f.seek(self.tell_pos)
            f.write(data)
            self.tell_pos = f.tell()
