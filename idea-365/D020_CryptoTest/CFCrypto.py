import os
import struct
import hashlib
from Crypto.Cipher import DES
from Crypto.PublicKey import RSA
from Crypto.Random import get_random_bytes
from Crypto.Cipher import AES, PKCS1_OAEP

"""封装好的文件加密解密类"""


# DES加密解密类
class DESCrypto(object):
    # 初始化时设置好密码
    def __init__(self, key):
        if len(key) == 0 or len(key) > 8:
            raise ValueError('Password\'s length more than 8!')
        # 密码不足8个字节将密码补足为8个字节
        while len(key) < 8:
            key += ' '
        self.key = key.encode('utf-8')

    # 加密文件，默认每次读取block_size
    def encrypt(self, file_path, output_file_path, block_size=32768):
        if os.path.exists(output_file_path):
            print('output_file exits!')
            return
        des = DES.new(self.key, DES.MODE_ECB)
        # 如果文件长度不是8字节的整数倍则需要在尾部填充
        file_len = os.path.getsize(file_path)
        pad_num = 0
        if file_len % 8 != 0:
            pad_num = 8 - file_len % 8
        # 填充数转为二进制
        pad = struct.pack('B', pad_num)
        with open(output_file_path, 'wb') as out:
            # 二进制方式写入第一个字节，这个数字用来标识尾部填充的个数
            out.write(pad)
        with open(file_path, 'rb') as f:
            while True:
                data = f.read(block_size)
                data_len = len(data)
                if not data:
                    break
                while data_len % 8 != 0:
                    data += b'0'
                    data_len = len(data)
                with open(output_file_path, 'ab') as out:
                    out.write(des.encrypt(data))

    # 解密文件，默认每次读取block_size
    def decrypt(self, file_path, output_file_path, block_size=32768):
        if os.path.exists(output_file_path):
            print('output_file exits!')
            return
        des = DES.new(self.key, DES.MODE_ECB)
        with open(file_path, 'rb') as f:
            pad_byte = f.read(1)
            pad_num, = struct.unpack('B', pad_byte)
            file_len = os.path.getsize(file_path)
            count = (file_len - 1) // block_size
            left = (file_len - 1) % block_size
            while True:
                data = f.read(block_size)
                des_bytes = des.decrypt(data)
                if count == 1 and left == 0 and pad_num != 0:
                    des_bytes = des_bytes[:-pad_num]
                elif count == 0 and left != 0 and pad_num != 0:
                    des_bytes = des_bytes[:-pad_num]
                elif count < 0:
                    break
                count -= 1
                with open(output_file_path, 'ab') as out:
                    out.write(des_bytes)


# AES加密解密类
class AESCrypto(object):
    # 初始化时设置好密码
    def __init__(self, key):
        md5 = hashlib.md5()
        md5.update(key.encode('utf-8'))
        self.key = md5.digest()

    # 加密文件，默认每次读取block_size
    def encrypt(self, file_path, output_file_path, block_size=32768):
        if os.path.exists(output_file_path):
            print('output_file exits!')
            return
        aes = AES.new(self.key, AES.MODE_ECB)
        # 如果文件长度不是16字节的整数倍则需要在尾部填充
        file_len = os.path.getsize(file_path)
        pad_num = 0
        if file_len % 16 != 0:
            pad_num = 16 - file_len % 16
        # 填充数转为二进制
        pad = struct.pack('B', pad_num)
        with open(output_file_path, 'wb') as out:
            # 二进制方式写入第一个字节，这个数字用来标识尾部填充的个数
            out.write(pad)
        with open(file_path, 'rb') as f:
            while True:
                data = f.read(block_size)
                data_len = len(data)
                if not data:
                    break
                while data_len % 16 != 0:
                    data += b'0'
                    data_len = len(data)
                with open(output_file_path, 'ab') as out:
                    out.write(aes.encrypt(data))

    # 解密文件，默认每次读取block_size
    def decrypt(self, file_path, output_file_path, block_size=32768):
        if os.path.exists(output_file_path):
            print('output_file exits!')
            return
        aes = AES.new(self.key, AES.MODE_ECB)
        with open(file_path, 'rb') as f:
            pad_byte = f.read(1)
            pad_num, = struct.unpack('B', pad_byte)
            file_len = os.path.getsize(file_path)
            count = (file_len - 1) // block_size
            left = (file_len - 1) % block_size
            while True:
                data = f.read(block_size)
                aes_bytes = aes.decrypt(data)
                if count == 1 and left == 0 and pad_num != 0:
                    aes_bytes = aes_bytes[:-pad_num]
                elif count == 0 and left != 0 and pad_num != 0:
                    aes_bytes = aes_bytes[:-pad_num]
                elif count < 0:
                    break
                count -= 1
                with open(output_file_path, 'ab') as out:
                    out.write(aes_bytes)


# RSA加密解密类
class RSACrypto(object):
    def __init__(self):
        self.code = None
        self.private_key_path = None
        self.public_key_path = None

    # 设置私钥密码
    def set_password(self, password):
        self.code = password

    # 设置私钥文件的路径
    def set_private_key_path(self, private_key_path):
        self.private_key_path = private_key_path

    # 设置公钥文件的路径
    def set_public_key_path(self, public_key_path):
        self.public_key_path = public_key_path

    # 根据私钥密码生成私钥和公钥
    def generate_key(self):
        if not self.code:
            print('Please set password first!')
        elif not self.private_key_path:
            print('Please set private_key_path!')
        elif not self.public_key_path:
            print('Please set public_key_path!')
        else:
            key = RSA.generate(2048)
            encrypted_key = key.exportKey(passphrase=self.code, pkcs=8,
                                          protection="scryptAndAES128-CBC")
            with open(self.private_key_path, 'wb') as f:
                f.write(encrypted_key)
            with open(self.public_key_path, 'wb') as f:
                f.write(key.publickey().exportKey())

    # 加密文件，需要设置公钥文件
    def encrypt(self, file_path, output_file_path):
        if not self.public_key_path:
            print('Please set public_key_path!')
        else:
            with open(output_file_path, 'wb') as out_file:
                recipient_key = RSA.import_key(
                    open(self.public_key_path).read())
                session_key = get_random_bytes(16)
                cipher_rsa = PKCS1_OAEP.new(recipient_key)
                out_file.write(cipher_rsa.encrypt(session_key))
                cipher_aes = AES.new(session_key, AES.MODE_EAX)
                with open(file_path, 'rb') as f:
                    data = f.read()
                cipher_text, tag = cipher_aes.encrypt_and_digest(data)
                out_file.write(cipher_aes.nonce)
                out_file.write(tag)
                out_file.write(cipher_text)

    # 解密文件，需要设置私钥密码和私钥文件
    def decrypt(self, file_path, output_file_path):
        if not self.code:
            print('Please set password first!')
        elif not self.private_key_path:
            print('Please set private_key_path!')
        else:
            with open(file_path, 'rb') as file:
                private_key = RSA.import_key(
                    open(self.private_key_path).read(),
                    passphrase=self.code)
                enc_session_key, nonce, tag, cipher_text = [file.read(x)
                                                            for x in (private_key.size_in_bytes(), 16, 16, -1)]
                cipher_rsa = PKCS1_OAEP.new(private_key)
                session_key = cipher_rsa.decrypt(enc_session_key)
                cipher_aes = AES.new(session_key, AES.MODE_EAX, nonce)
                data = cipher_aes.decrypt_and_verify(cipher_text, tag)
            with open(output_file_path, 'wb') as f:
                f.write(data)
