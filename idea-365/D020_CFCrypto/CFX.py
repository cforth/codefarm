import hashlib
import base64
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
        self.use_urlsafe = use_urlsafe
        # 生成密钥时，选择是否加盐，是否使用md5值
        self.key = gen_aes_key(password, salt, use_md5)
        self.cipher = None

    # 加密字符串
    def encrypt(self, string, iv):
        pad_byte_string = pad(string.encode('utf-8'), AES.block_size)
        if self.use_urlsafe:
            iv_byte = base64.urlsafe_b64encode(iv)
            self.cipher = AES.new(self.key, AES.MODE_CBC, iv_byte)
            encrypt_byte_string = self.cipher.encrypt(pad_byte_string)
            encrypt_string = base64.urlsafe_b64encode(encrypt_byte_string).decode('utf-8')
        else:
            iv_byte = base64.b64decode(iv)
            self.cipher = AES.new(self.key, AES.MODE_CBC, iv_byte)
            encrypt_byte_string = self.cipher.encrypt(pad_byte_string)
            encrypt_string = base64.b64encode(encrypt_byte_string).decode('utf-8')
        return iv, encrypt_string

    # 解密字符串
    def decrypt(self, encrypt_string, iv):
        if self.use_urlsafe:
            encrypt_byte_string = base64.urlsafe_b64decode(bytes(map(ord, encrypt_string)))
            iv_byte = base64.urlsafe_b64decode(iv)
        else:
            encrypt_byte_string = base64.b64decode(bytes(map(ord, encrypt_string)))
            iv_byte = base64.b64decode(iv)
        # 使用CBC模式进行解密
        self.cipher = AES.new(self.key, AES.MODE_CBC, iv_byte)
        pad_byte_string = self.cipher.decrypt(encrypt_byte_string)
        string = unpad(pad_byte_string, AES.block_size).decode('utf-8')
        return string
