import hashlib
import os
import base64
import re
import multiprocessing
import time
from multiprocessing import Pool
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad


MULTIPLE_OF_BYTE = 16


def generate_key(password):
    # 将密码转为md5值作为密钥
    md5 = hashlib.md5()
    md5.update(password.encode('utf-8'))
    return md5.digest()


# 字符串加密解密类
class StringCrypto(object):
    def __init__(self, password):
        self.key = generate_key(password)
        self.cipher = AES.new(self.key, AES.MODE_ECB)

    # 加密字符串
    # 将字符串转为字节串进行AES加密，
    # 再将加密后的字节串转为16进制字符串，
    # 再通过base64模块编码
    def encrypt(self, string):
        pad_byte_string = pad(string.encode('utf-8'), MULTIPLE_OF_BYTE)
        encrypt_byte_string = self.cipher.encrypt(pad_byte_string)
        encrypt_string = base64.urlsafe_b64encode(encrypt_byte_string).decode('ascii')
        return encrypt_string

    # 解密字符串
    # 步骤与加密相反
    def decrypt(self, encrypt_string):
        encrypt_byte_string = base64.urlsafe_b64decode(bytes(map(ord, encrypt_string)))
        pad_byte_string = self.cipher.decrypt(encrypt_byte_string)
        string = unpad(pad_byte_string, MULTIPLE_OF_BYTE).decode('utf-8')
        return string


def file_handle(file_path, output_file_path, block_size, data_handle_func, data_end_handle_func):
    if not os.path.exists(file_path):
        raise ValueError('Input file path not exists: %s ', file_path)
    elif os.path.exists(output_file_path):
        raise ValueError('Output file exists: %s', output_file_path)

    print('Run task %s (%s)...' % (file_path, os.getpid()))
    start = time.time()
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
    end = time.time()
    print('Task %s runs %0.2f seconds.' % (file_path, (end - start)))


# 加密文件
def file_encrypt(password, file_path, output_file_path):
    key = generate_key(password)
    # 使用ECB模式进行加密解密
    cipher = AES.new(key, AES.MODE_ECB)
    # 设置加密解密时分块读取10240KB
    read_kb = 10240
    block_size = read_kb * 1024
    data_handle_func = cipher.encrypt
    # 读取到文件尾部时，执行尾部补位操作后加密
    data_end_handle_func = lambda d: cipher.encrypt(pad(d, MULTIPLE_OF_BYTE))
    file_handle(file_path, output_file_path, block_size, data_handle_func, data_end_handle_func)


# 解密文件
def file_decrypt(password, file_path, output_file_path):
    key = generate_key(password)
    # 使用ECB模式进行加密解密
    cipher = AES.new(key, AES.MODE_ECB)
    # 设置加密解密时分块读取10240KB
    read_kb = 10240
    block_size = read_kb * 1024
    data_handle_func = cipher.decrypt
    # 读取到文件尾部时，执行解密后尾部去除补位
    data_end_handle_func = lambda d: unpad(cipher.decrypt(d), MULTIPLE_OF_BYTE)
    file_handle(file_path, output_file_path, block_size, data_handle_func, data_end_handle_func)


# 文件夹加密解密类
class DirFileCrypto(object):
    def __init__(self, password):
        # 将用password加密文件名和文件
        self.password = password
        self.string_crypto = StringCrypto(password)

    # 路径加密解密静态方法
    @staticmethod
    def dir_path_handle(path_string, name_handle_func):
        name_list = re.split(r'[\\/]', path_string)
        crypto_list = [name_handle_func(s) for s in name_list]
        return '/'.join(crypto_list)

    # 文件夹处理静态方法
    # 复制input_dir的目录结构（包含子目录结构）应用name_handle_func方法后新建在output_dir中
    # 对input_dir中的所有文件（包含子目录中的文件）应用file_handle_func方法，文件名应用name_handle_func方法
    # 将处理后的文件存放到output_dir中
    @staticmethod
    def handle(password, input_dir, output_dir, file_handle_func, name_handle_func):
        real_input_dir = os.path.abspath(input_dir).replace('\\', '/')
        real_output_dir = os.path.abspath(output_dir).replace('\\', '/')
        if not os.path.exists(real_input_dir):
            raise ValueError('Input Dir not exists: %s', real_input_dir)

        if not os.path.exists(real_output_dir):
            os.mkdir(real_output_dir)

        root_parent_dir = os.path.split(real_input_dir)[0]
        root_dir = os.path.split(real_input_dir)[1]
        # 如果在磁盘根目录下，要把根目录后的‘/’计入长度
        root_dir_index = len(root_parent_dir) if root_parent_dir.endswith('/') else len(root_parent_dir) + 1
        real_output_subdir = os.path.join(real_output_dir, name_handle_func(root_dir))

        if not os.path.exists(real_output_subdir):
            os.mkdir(real_output_subdir)

        # 设置进程池，进程数为CPU核数
        process_pool = Pool(multiprocessing.cpu_count())
        print(process_pool)
        for path, subdir, files in os.walk(input_dir):

            # 将当前路径path转为加密后的文件夹路径now_output_path
            now_output_path = DirFileCrypto.dir_path_handle(os.path.abspath(path)[root_dir_index:], name_handle_func)
            for d in subdir:
                real_output_subdir = os.path.join(real_output_dir, now_output_path, name_handle_func(d))
                if not os.path.exists(real_output_subdir):
                    os.mkdir(real_output_subdir)

            for f in files:
                input_file_path = os.path.join(os.path.abspath(path), f)
                output_file_path = os.path.join(real_output_dir, now_output_path, name_handle_func(f))
                process_pool.apply_async(file_handle_func, args=(password, input_file_path, output_file_path))
                #file_handle_func(input_file_path, output_file_path)
        print('Waiting for all subprocesses done...')
        process_pool.close()
        process_pool.join()
        print("All subprocesses done.")

    # 加密input_dir文件夹内的所有文件到output_dir
    def encrypt(self, input_dir, output_dir):
        DirFileCrypto.handle(self.password, input_dir, output_dir, file_encrypt, self.string_crypto.encrypt)

    # 解密input_dir文件夹内的所有文件到output_dir
    def decrypt(self, input_dir, output_dir):
        DirFileCrypto.handle(self.password, input_dir, output_dir, file_decrypt, self.string_crypto.decrypt)
