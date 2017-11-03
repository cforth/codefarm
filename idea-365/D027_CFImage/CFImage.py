from tkinter import *
import base64
import hashlib
import os
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad


class ByteCrypto:
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
        
    @staticmethod
    def handle(file_path, block_size, data_handle_func, data_end_handle_func):
        if not os.path.exists(file_path):
            raise ValueError('Input file path not exists: %s ', file_path)

        file_len = os.path.getsize(file_path)
        res_data = bytes()
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
                res_data = res_data + data
        return res_data
                    
    # 加密文件
    def encrypt(self, file_path):
        block_size = self.read_kb * 1024
        data_handle_func = self.cipher.encrypt
        # 读取到文件尾部时，执行尾部补位操作后加密
        data_end_handle_func = lambda d: self.cipher.encrypt(pad(d, self.multiple_of_byte))
        return ByteCrypto.handle(file_path, block_size, data_handle_func, data_end_handle_func)

    # 解密文件
    def decrypt(self, file_path):
        block_size = self.read_kb * 1024
        data_handle_func = self.cipher.decrypt
        # 读取到文件尾部时，执行解密后尾部去除补位
        data_end_handle_func = lambda d: unpad(self.cipher.decrypt(d), self.multiple_of_byte)
        return ByteCrypto.handle(file_path, block_size, data_handle_func, data_end_handle_func)


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
        string = unpad(pad_byte_string, self.multiple_of_byte).decode('utf-8')
        return string


def main():
    password = '25555225'
    filename = 'gkIEIa8buFYYlIpTGDDOzw=='
    filepath = 'f:/temp/gkIEIa8buFYYlIpTGDDOzw=='
    
    titlestr = StringCrypto(password).decrypt(filename)
    encodestr = base64.b64encode(ByteCrypto(password).decrypt(filepath))
    
    root = Tk()
    root.title(titlestr)
    # 注意使用base64字符串时，需要指定为data参数
    img = PhotoImage(data=encodestr)
    label = Label(root, image=img)
    label.pack()
    root.mainloop()

main()
