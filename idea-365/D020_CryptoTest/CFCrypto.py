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
        if len(key) > 8:
            raise ValueError('Password\'s length more than 8!')
        # 密码不足8个字节将密码补足为8个字节
        while len(key) < 8:
            key += ' '
        self.key = key.encode('utf-8')

    # 加密文件，分块加密文件，每次加密buffer_size*8个字节
    def encrypt(self, file_path, output_file_path, buffer_size=4096):
        # 对大文件进行分块加密，每次加密block_size个字节
        block_size = buffer_size * 8
        # 使用ECB模式进行加密
        des = DES.new(self.key, DES.MODE_ECB)
        with open(output_file_path, 'wb') as out:
            # 如果文件长度不是8字节的整数倍则需要在尾部填充
            file_len = os.path.getsize(file_path)
            pad_num = 0 if file_len % 8 == 0 else 8 - file_len % 8
            # 填充数转为二进制
            pad_byte = struct.pack('B', pad_num)
            # 二进制方式写入第一个字节，这个数字用来标识尾部填充字节的个数
            out.write(pad_byte)
        with open(file_path, 'rb') as f:
            while True:
                data = f.read(block_size)
                if not data:
                    break
                # 读取最后一个文件块时，对尾部填充使之为8字节的整数倍
                while len(data) % 8 != 0:
                    data += b'0'
                with open(output_file_path, 'ab') as out:
                    out.write(des.encrypt(data))

    # 解密文件，分块解密文件，每次加密buffer_size*8个字节
    def decrypt(self, file_path, output_file_path, buffer_size=4096):
        # 对大文件进行分块解密，每次解密block_size个字节
        block_size = buffer_size * 8
        # 使用ECB模式进行解密
        des = DES.new(self.key, DES.MODE_ECB)
        with open(file_path, 'rb') as f:
            pad_byte = f.read(1)
            pad_num, = struct.unpack('B', pad_byte)
            # 文件长度要减掉第一个标识字节
            file_len = os.path.getsize(file_path) - 1
            # 计算需处理的文件块数count，最后一个文件块的大小left
            count = file_len // block_size
            left = file_len % block_size
            while True:
                data = f.read(block_size)
                # 对最后一个文件块进行分情况处理，删除尾部填充的字节
                file_bytes = des.decrypt(data)
                if count == 1 and left == 0 and pad_num != 0:
                    file_bytes = file_bytes[:-pad_num]
                elif count == 0 and left != 0 and pad_num != 0:
                    file_bytes = file_bytes[:-pad_num]
                elif count < 0:
                    break
                count -= 1
                with open(output_file_path, 'ab') as out:
                    out.write(file_bytes)


# AES加密解密类
class AESCrypto(object):
    # 初始化时设置好密码
    def __init__(self, key):
        # 将密码转为md5值作为密钥
        md5 = hashlib.md5()
        md5.update(key.encode('utf-8'))
        self.key = md5.digest()

    # 加密文件，分块加密文件，每次加密buffer_size*16个字节
    def encrypt(self, file_path, output_file_path, buffer_size=2048):
        # 对大文件进行分块加密，每次加密block_size个字节
        block_size = buffer_size * 16
        # 使用ECB模式进行加密
        aes = AES.new(self.key, AES.MODE_ECB)
        # 如果文件长度不是16字节的整数倍则需要在尾部填充
        file_len = os.path.getsize(file_path)
        pad_num = 0 if file_len % 16 == 0 else 16 - file_len % 16
        # 填充数转为二进制
        pad_byte = struct.pack('B', pad_num)
        with open(output_file_path, 'wb') as out:
            # 二进制方式写入第一个字节，这个数字用来标识尾部填充的个数
            out.write(pad_byte)
        with open(file_path, 'rb') as f:
            while True:
                data = f.read(block_size)
                if not data:
                    break
                while len(data) % 16 != 0:
                    data += b'0'
                with open(output_file_path, 'ab') as out:
                    out.write(aes.encrypt(data))

    # 解密文件，分块解密文件，每次加密buffer_size*16个字节
    def decrypt(self, file_path, output_file_path, buffer_size=2048):
        # 对大文件进行分块解密，每次解密block_size个字节
        block_size = buffer_size * 16
        # 使用ECB模式进行解密
        aes = AES.new(self.key, AES.MODE_ECB)
        with open(file_path, 'rb') as f:
            pad_byte = f.read(1)
            pad_num, = struct.unpack('B', pad_byte)
            # 文件长度要减掉第一个标识字节
            file_len = os.path.getsize(file_path) - 1
            # 计算需处理的文件块数count，最后一个文件块的大小left
            count = file_len // block_size
            left = file_len % block_size
            while True:
                data = f.read(block_size)
                # 对最后一个文件块进行分情况处理，删除尾部填充的字节
                file_bytes = aes.decrypt(data)
                if count == 1 and left == 0 and pad_num != 0:
                    file_bytes = file_bytes[:-pad_num]
                elif count == 0 and left != 0 and pad_num != 0:
                    file_bytes = file_bytes[:-pad_num]
                elif count < 0:
                    break
                count -= 1
                with open(output_file_path, 'ab') as out:
                    out.write(file_bytes)


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
                public_file = open(self.public_key_path)
                recipient_key = RSA.import_key(
                    public_file.read())
                session_key = get_random_bytes(16)
                cipher_rsa = PKCS1_OAEP.new(recipient_key)
                out_file.write(cipher_rsa.encrypt(session_key))
                cipher_aes = AES.new(session_key, AES.MODE_EAX)
                public_file.close()
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
                private_file = open(self.private_key_path)
                private_key = RSA.import_key(
                    private_file.read(),
                    passphrase=self.code)
                enc_session_key, nonce, tag, cipher_text = [file.read(x)
                                                            for x in (private_key.size_in_bytes(), 16, 16, -1)]
                cipher_rsa = PKCS1_OAEP.new(private_key)
                session_key = cipher_rsa.decrypt(enc_session_key)
                cipher_aes = AES.new(session_key, AES.MODE_EAX, nonce)
                data = cipher_aes.decrypt_and_verify(cipher_text, tag)
                private_file.close()
            with open(output_file_path, 'wb') as f:
                f.write(data)