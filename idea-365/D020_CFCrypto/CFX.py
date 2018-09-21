import hashlib
import base64
import os
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad


# '\0'填充密码
def null_pad(data_to_pad):
    data_len = len(data_to_pad)
    # 不超过128位的密码填充长度（字节单位）
    if data_len <= 16:
        key_len = 16
    # 128位以上，不超过192位的密码填充长度（字节单位）
    elif data_len > 16 and data_len <= 24:
        key_len = 24
    # 192位以上，不超过256位的密码填充长度（字节单位）
    elif data_len > 24 and data_len <= 32:
        key_len = 32
    # 超过256位的密码直接截断到256位长度
    else:
        return data_to_pad[:32]
    # 进行'\0'填充
    padding_len = key_len - len(data_to_pad)
    padding = b'\0' * padding_len
    return data_to_pad + padding


# 生成密钥
def gen_aes_key(password, salt, use_md5):
    # 将密码加盐，防止泄露原始密码
    if salt:
        password += salt

    if use_md5:
        # 将密码转为md5值作为密钥
        md5 = hashlib.md5()
        md5.update(password.encode('utf-8'))
        key = md5.digest()
    else:
        key = null_pad(password.encode('utf-8'))

    return key


# 字符串加密解密类
class StringCrypto(object):
    def __init__(self, password, salt="", use_md5=False, use_urlsafe=False):
        # 是否使用urlsafe模式下的base64编码
        self.use_urlsafe = use_urlsafe
        # 生成密钥时，选择是否加盐，是否使用md5值
        self.key = gen_aes_key(password, salt, use_md5)
        self.cipher = None

    # 加密字符串，iv默认为None时随机生成
    def encrypt(self, string, iv_str=None):
        # 将原字符串长度补齐到AES.block_size的整数倍长度
        pad_byte_string = pad(string.encode('utf-8'), AES.block_size)
        if iv_str:
            # iv为初始化向量，AES为16字节
            iv = base64.urlsafe_b64decode(iv_str) if self.use_urlsafe else base64.b64decode(iv_str)
            self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        else:
            # 未指定iv，则随机生成一个
            self.cipher = AES.new(self.key, AES.MODE_CBC)
            if self.use_urlsafe:
                iv_str = base64.urlsafe_b64encode(self.cipher.iv).decode('utf-8')
            else:
                iv_str = base64.b64encode(self.cipher.iv).decode('utf-8')
        # 使用AES-128的CBC模式加密字符串
        ct_bytes = self.cipher.encrypt(pad_byte_string)
        if self.use_urlsafe:
            ct = base64.urlsafe_b64encode(ct_bytes).decode('utf-8')
        else:
            ct = base64.b64encode(ct_bytes).decode('utf-8')
        return iv_str, ct

    # 解密字符串
    def decrypt(self, encrypt_string, iv_str):
        if self.use_urlsafe:
            encrypt_byte_string = base64.urlsafe_b64decode(bytes(map(ord, encrypt_string)))
            iv = base64.urlsafe_b64decode(iv_str)
        else:
            encrypt_byte_string = base64.b64decode(bytes(map(ord, encrypt_string)))
            iv = base64.b64decode(iv_str)
        # 使用AES-128的CBC模式进行解密
        self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        pad_byte_string = self.cipher.decrypt(encrypt_byte_string)
        string = unpad(pad_byte_string, AES.block_size).decode('utf-8')
        return iv_str, string


# 将文件加密或解密，返回二进制数据(用于小文件)
class ByteCrypto(object):
    def __init__(self, password, salt="", use_md5=False, use_urlsafe=False):
        # 生成密钥时，选择是否加盐，是否使用md5值
        self.key = gen_aes_key(password, salt, use_md5)
        self.use_urlsafe = use_urlsafe
        self.cipher = None

    def encrypt(self, file_path, iv_str=None):
        if not os.path.exists(file_path):
            raise ValueError('Input file path not exists: %s ', file_path)

        with open(file_path, 'rb') as f:
            data_to_encrypt = f.read()

        if iv_str:
            # iv为初始化向量，AES为16字节
            iv = base64.urlsafe_b64decode(iv_str) if self.use_urlsafe else base64.b64decode(iv_str)
            self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        else:
            # 未指定iv，则随机生成一个
            self.cipher = AES.new(self.key, AES.MODE_CBC)
            if self.use_urlsafe:
                iv_str = base64.urlsafe_b64encode(self.cipher.iv).decode('utf-8')
            else:
                iv_str = base64.b64encode(self.cipher.iv).decode('utf-8')

        return iv_str, self.cipher.encrypt(pad(data_to_encrypt, AES.block_size))

    def decrypt(self, file_path, iv_str):
        if not os.path.exists(file_path):
            raise ValueError('Input file path not exists: %s ', file_path)

        with open(file_path, 'rb') as f:
            data_to_decrypt = f.read()

        if self.use_urlsafe:
            iv = base64.urlsafe_b64decode(iv_str)
        else:
            iv = base64.b64decode(iv_str)

        # 使用AES-128的CBC模式进行解密
        self.cipher = AES.new(self.key, AES.MODE_CBC, iv)
        return iv_str, unpad(self.cipher.decrypt(data_to_decrypt), AES.block_size)
