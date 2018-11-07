import hashlib
import base64
from functools import partial
import os
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

# 读写文件时，每次读写的数据量
BUFFER_SIZE = 10 * 1024 * 1024


# 加密解密基类，设置密码和其他参数
class BaseCrypto(object):
    def __init__(self, password, iv_str=None, salt=None, use_md5=False, use_urlsafe=False, buffer_size=BUFFER_SIZE):
        self._iv_str = iv_str
        # 生成密钥时，选择是否加盐，是否使用md5值
        self.key = self.gen_aes_key(password, salt, use_md5)
        self.use_urlsafe = use_urlsafe
        self.buffer_size = buffer_size
        self.cipher = None

    # 获得iv_str，初始化向量的字符串表现形式
    @property
    def iv_str(self):
        return self._iv_str

    # b'\0'填充密码
    def null_pad(self, data_to_pad):
        data_len = len(data_to_pad)
        # 不超过128位的密码填充长度（字节单位）
        if data_len <= 16:
            key_len = 16
        # 128位以上，不超过192位的密码填充长度（字节单位）
        elif 16 < data_len <= 24:
            key_len = 24
        # 192位以上，不超过256位的密码填充长度（字节单位）
        elif 24 < data_len <= 32:
            key_len = 32
        # 超过256位的密码直接截断到256位长度
        else:
            return data_to_pad[:32]
        # 进行'\0'填充
        padding_len = key_len - len(data_to_pad)
        padding = b'\0' * padding_len
        return data_to_pad + padding

    # 生成密钥
    def gen_aes_key(self, password, salt, use_md5):
        # 将密码加盐，防止泄露原始密码
        password = password + salt if salt else password
        # use_md5为True值时，将密码转为md5值作为密钥，否则使用b'\0'填充密码
        if use_md5:
            md5 = hashlib.md5()
            md5.update(password.encode('utf-8'))
            key = md5.digest()
        else:
            key = self.null_pad(password.encode('utf-8'))

        return key


# 字符串加密解密类
class StringCrypto(BaseCrypto):
    def __init__(self, password, iv_str=None, salt=None, use_md5=False, use_urlsafe=False):
        super().__init__(password, iv_str, salt, use_md5, use_urlsafe)

    # 加密字符串，iv_str默认为None时随机生成
    def encrypt(self, original_string):
        # 将原字符串长度补齐到AES.block_size的整数倍长度
        pad_byte_string = pad(original_string.encode('utf-8'), AES.block_size)
        if self._iv_str:
            # iv为初始化向量，AES为16字节
            iv = base64.urlsafe_b64decode(self._iv_str) if self.use_urlsafe else base64.b64decode(self._iv_str)
            self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        else:
            # 未指定iv，则随机生成一个，并设定iv_str
            self.cipher = AES.new(self.key, AES.MODE_CBC)
            if self.use_urlsafe:
                self._iv_str = base64.urlsafe_b64encode(self.cipher.iv).decode('utf-8')
            else:
                self._iv_str = base64.b64encode(self.cipher.iv).decode('utf-8')
        # 使用AES-128的CBC模式加密字符串
        ct_bytes = self.cipher.encrypt(pad_byte_string)
        if self.use_urlsafe:
            encrypt_string = base64.urlsafe_b64encode(ct_bytes).decode('utf-8')
        else:
            encrypt_string = base64.b64encode(ct_bytes).decode('utf-8')
        return encrypt_string

    # 解密字符串
    def decrypt(self, encrypt_string):
        if self.use_urlsafe:
            encrypt_byte_string = base64.urlsafe_b64decode(bytes(map(ord, encrypt_string)))
            iv = base64.urlsafe_b64decode(self._iv_str)
        else:
            encrypt_byte_string = base64.b64decode(bytes(map(ord, encrypt_string)))
            iv = base64.b64decode(self._iv_str)
        # 使用AES-128的CBC模式进行解密
        self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        pad_byte_string = self.cipher.decrypt(encrypt_byte_string)
        original_string = unpad(pad_byte_string, AES.block_size).decode('utf-8')
        return original_string


# 将二进制数据加密或解密，返回二进制数据(一次性读入内存加密，用于小文件)
class ByteCrypto(BaseCrypto):
    def __init__(self, password, iv_str=None, salt=None, use_md5=False, use_urlsafe=False):
        super().__init__(password, iv_str, salt, use_md5, use_urlsafe)

    def encrypt(self, original_data):
        if self._iv_str:
            # iv为初始化向量，AES为16字节
            iv = base64.urlsafe_b64decode(self._iv_str) if self.use_urlsafe else base64.b64decode(self._iv_str)
            self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        else:
            # 未指定iv，则随机生成一个
            self.cipher = AES.new(self.key, AES.MODE_CBC)
            if self.use_urlsafe:
                self._iv_str = base64.urlsafe_b64encode(self.cipher.iv).decode('utf-8')
            else:
                self._iv_str = base64.b64encode(self.cipher.iv).decode('utf-8')
        return self.cipher.encrypt(pad(original_data, AES.block_size))

    def decrypt(self, data_to_decrypt):
        if self.use_urlsafe:
            iv = base64.urlsafe_b64decode(self._iv_str)
        else:
            iv = base64.b64decode(self._iv_str)
        # 使用AES-128的CBC模式进行解密
        self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        return unpad(self.cipher.decrypt(data_to_decrypt), AES.block_size)


# 将文件加密或解密，指定block_size作为每次读取写入的数据量，用于大文件
class FileCrypto(BaseCrypto):
    def __init__(self, password, iv_str=None, salt=None, use_md5=False, use_urlsafe=False, buffer_size=BUFFER_SIZE):
        super().__init__(password, iv_str, salt, use_md5, use_urlsafe, buffer_size)
        # 加密解密的状态
        self.crypto_status = False
        # 已经读取的数据长度
        self.read_len = 0
        # 记录是否被外部中止
        self.stop_flag = False

    # 获取加密解密状态与已经读取的数据长度，用于显示状态
    def get_status(self):
        return self.crypto_status, self.read_len

    # 停止任务
    def stop_handle(self):
        self.crypto_status = False
        self.stop_flag = True

    # 是否被外部中止任务
    def if_stop(self):
        return self.stop_flag

    # 文件处理方法
    def handle(self, file_path, output_file_path, data_handle_func, data_end_handle_func):
        if not os.path.exists(file_path):
            raise ValueError('Input file path not exists: %s ', file_path)
        elif os.path.exists(output_file_path):
            raise ValueError('Output file exists: %s', output_file_path)

        file_len = os.path.getsize(file_path)
        self.crypto_status = True
        self.stop_flag = False
        try:
            with open(file_path, 'rb') as f:
                self.read_len = 0
                data_iter = iter(partial(f.read, self.buffer_size), b'')
                for data in data_iter:
                    if not self.crypto_status:
                        break
                    self.read_len += len(data)
                    if self.read_len == file_len:
                        data = data_end_handle_func(data)
                    else:
                        data = data_handle_func(data)
                    with open(output_file_path, 'ab') as out:
                        out.write(data)
        except Exception as e:
            raise e
        finally:
            self.crypto_status = False

    def encrypt(self, file_path, output_file_path):
        if self._iv_str:
            # iv为初始化向量，AES为16字节
            iv = base64.urlsafe_b64decode(self._iv_str) if self.use_urlsafe else base64.b64decode(self._iv_str)
            self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        else:
            # 未指定iv，则随机生成一个
            self.cipher = AES.new(self.key, AES.MODE_CBC)
            if self.use_urlsafe:
                self._iv_str = base64.urlsafe_b64encode(self.cipher.iv).decode('utf-8')
            else:
                self._iv_str = base64.b64encode(self.cipher.iv).decode('utf-8')

        data_handle_func = self.cipher.encrypt
        # 读取到文件尾部时，执行尾部补位操作后加密
        data_end_handle_func = lambda d: self.cipher.encrypt(pad(d, AES.block_size))
        self.handle(file_path, output_file_path, data_handle_func, data_end_handle_func)

    def decrypt(self, file_path, output_file_path):
        if self.use_urlsafe:
            iv = base64.urlsafe_b64decode(self._iv_str)
        else:
            iv = base64.b64decode(self._iv_str)

        # 使用AES-128的CBC模式进行解密
        self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        data_handle_func = self.cipher.decrypt
        # 读取到文件尾部时，执行解密后尾部去除补位
        data_end_handle_func = lambda d: unpad(self.cipher.decrypt(d), AES.block_size)
        self.handle(file_path, output_file_path, data_handle_func, data_end_handle_func)
