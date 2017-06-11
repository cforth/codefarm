import hashlib
import os
import struct
import base64
from Crypto.Cipher import AES


# PKCS5填充方式，将数据填充为multiple_of_byte的整数倍
def pad(bin_str, multiple_of_byte):
    length = len(bin_str)
    fill_num = multiple_of_byte if length % multiple_of_byte == 0 \
        else multiple_of_byte - length % multiple_of_byte
    # 填充数转为二进制
    fill_byte = struct.pack('B', fill_num)
    if length % multiple_of_byte != 0:
        while len(bin_str) % multiple_of_byte != 0:
            bin_str += fill_byte
    else:
        for x in range(0, multiple_of_byte):
            bin_str += fill_byte
    return bin_str


# PKCS5填充方式，将填充过的数据恢复
def un_pad(bin_str):
    return bin_str[:-bin_str[-1]]


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
        string = un_pad(pad_byte_string).decode('utf-8')
        return string


# 文件加密解密类
class FileCrypto(object):
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

    # 文件处理静态方法
    # 每次读取block_size字节的file_path
    # 每次读取后，正常是执行data_handle_func方法
    # 如遇到file_path结尾，则执行data_end_handle_func方法
    # 写入处理后的数据到output_file_path
    @staticmethod
    def handle(file_path, output_file_path, block_size, data_handle_func, data_end_handle_func):
        file_len = os.path.getsize(file_path)
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
                with open(output_file_path, 'ab') as out:
                    out.write(data)

    # 加密文件
    def encrypt(self, file_path, output_file_path):
        block_size = self.read_kb * 1024
        data_handle_func = self.cipher.encrypt
        # 读取到文件尾部时，执行尾部补位操作后加密
        data_end_handle_func = lambda d: self.cipher.encrypt(pad(d, self.multiple_of_byte))
        FileCrypto.handle(file_path, output_file_path, block_size, data_handle_func, data_end_handle_func)

    # 解密文件
    def decrypt(self, file_path, output_file_path):
        block_size = self.read_kb * 1024
        data_handle_func = self.cipher.decrypt
        # 读取到文件尾部时，执行解密后尾部去除补位
        data_end_handle_func = lambda d: un_pad(self.cipher.decrypt(d))
        FileCrypto.handle(file_path, output_file_path, block_size, data_handle_func, data_end_handle_func)


# 文件夹加密解密类
class DirCrypto(object):
    def __init__(self, password):
        # 将用password加密文件名和文件
        self.file_crypto = FileCrypto(password)
        self.string_crypto = StringCrypto(password)

    # 文件夹处理静态方法
    # 复制input_dir的目录结构（包含子目录结构）到output_dir中
    # 对input_dir中的所有文件（包含子目录中的文件）的文件名应用name_handle_func方法
    # 对input_dir中的所有文件（包含子目录中的文件）应用file_handle_func方法
    # 将处理后的文件存放到output_dir中
    @staticmethod
    def handle(input_dir, output_dir, name_handle_func, file_handle_func):
        real_input_dir = os.path.abspath(input_dir)
        real_output_dir = os.path.abspath(output_dir)
        if not os.path.exists(real_input_dir):
            print('Input Dir not exists!')
            return

        if not os.path.exists(real_output_dir):
            os.mkdir(real_output_dir)

        root_dir_index = real_input_dir.rindex('\\', 0, len(real_input_dir) - 1) + 1
        real_output_subdir = real_output_dir + '\\' + os.path.abspath(real_input_dir)[root_dir_index:]

        if not os.path.exists(real_output_subdir):
            os.mkdir(real_output_subdir)

        for path, subdir, files in os.walk(input_dir):

            for d in subdir:
                real_output_subdir = real_output_dir + '\\' + os.path.abspath(path)[root_dir_index:] + '\\' + d
                if not os.path.exists(real_output_subdir):
                    os.mkdir(real_output_subdir)

            for f in files:
                input_file_path = os.path.abspath(path) + '\\' + f
                output_file_path = real_output_dir + '\\' + os.path.abspath(path)[root_dir_index:] + '\\' \
                                   + name_handle_func(f)
                file_handle_func(input_file_path, output_file_path)

    # 加密input_dir文件夹内的所有文件到output_dir
    def encrypt(self, input_dir, output_dir):
        DirCrypto.handle(input_dir, output_dir, self.string_crypto.encrypt, self.file_crypto.encrypt)

    # 解密input_dir文件夹内的所有文件到output_dir
    def decrypt(self, input_dir, output_dir):
        DirCrypto.handle(input_dir, output_dir, self.string_crypto.decrypt, self.file_crypto.decrypt)


# 文件夹名称加密解密类
class DirNameCrypto(object):
    def __init__(self, password):
        # 将用password加密文件夹名
        self.string_crypto = StringCrypto(password)

    # 修改文件夹名称的静态方法
    @staticmethod
    def handle(path, handle_func):
        os.chdir(path)
        for dir_or_file in os.listdir(path):
            if os.path.isdir(dir_or_file):
                DirNameCrypto.handle(os.getcwd() + '\\' + dir_or_file, handle_func)
                os.chdir('..')
                dir_name = handle_func(dir_or_file)
                if dir_name is not None:
                    os.rename(dir_or_file, dir_name)

    # 加密文件夹名称
    def encrypt(self, dir_path):
        if not os.path.exists(dir_path):
            print('Dir not exists!')
            return
        root_path = os.path.abspath('.')
        dir_path = os.path.abspath(dir_path)
        DirNameCrypto.handle(dir_path, self.string_crypto.encrypt)
        os.chdir(root_path)

    # 解密文件夹名称
    def decrypt(self, dir_path):
        if not os.path.exists(dir_path):
            print('Dir not exists!')
            return
        root_path = os.path.abspath('.')
        dir_path = os.path.abspath(dir_path)
        DirNameCrypto.handle(dir_path, self.string_crypto.decrypt)
        os.chdir(root_path)
