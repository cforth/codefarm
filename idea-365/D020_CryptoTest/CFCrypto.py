import os
import struct
import base64
import hashlib
from Crypto.Cipher import AES, DES
from Crypto.PublicKey import RSA
from Crypto.Random import get_random_bytes
from Crypto.Cipher import PKCS1_OAEP


# 大文件加密解密类
class CoolFileCrypto(object):
    def __init__(self, password, mode='AES'):
        if mode == 'AES':
            # 将密码转为md5值作为密钥
            md5 = hashlib.md5()
            md5.update(password.encode('utf-8'))
            self.key = md5.digest()
            # AES的ECB模式，数据的长度必须为16节的倍数
            self.multiple_of_byte = 16
            # 使用ECB模式进行加密解密
            self.chipher = AES.new(self.key, AES.MODE_ECB)

        elif mode == 'DES':
            if len(password) > 8:
                raise ValueError('Password\'s length more than 8!')
                # 密码不足8个字节将密码补足为8个字节
            while len(password) < 8:
                password += ' '
            self.key = password.encode('utf-8')
            # DES的ECB模式，数据的长度必须为8节的倍数
            self.multiple_of_byte = 8
            # 使用ECB模式进行加密解密
            self.chipher = DES.new(self.key, DES.MODE_ECB)

        else:
            raise ValueError("CoolFileCrypto init error! Mode must be 'AES' or 'DES'!")

        # 设置加密解密时分块读取10240KB
        self.read_kb = 10240

    # PKCS5填充方式，将数据填充为self.multiple_of_byte的整数倍
    def pad(self, bin_str):
        length = len(bin_str)
        fill_num = self.multiple_of_byte if length % self.multiple_of_byte == 0 \
            else self.multiple_of_byte - length % self.multiple_of_byte
        # 填充数转为二进制
        fill_byte = struct.pack('B', fill_num)
        if length % self.multiple_of_byte != 0:
            while len(bin_str) % self.multiple_of_byte != 0:
                bin_str += fill_byte
        else:
            for x in range(0, 16):
                bin_str += fill_byte
        return bin_str

    # PKCS5填充方式，将填充过的数据恢复
    def unpad(self, bin_str):
        return bin_str[:-bin_str[-1]]

    # 加密字符串
    # 将字符串转为字节串进行AES加密，
    # 再将加密后的字节串转为16进制字符串，
    # 再通过base64模块编码
    def encrypt_string(self, file_name):
        return base64.urlsafe_b64encode(self.chipher.encrypt(self.pad(file_name.encode('utf-8')))).decode('ascii')

    # 解密字符串
    # 步骤与加密相反
    def decrypt_string(self, file_name):
        return self.unpad(self.chipher.decrypt(base64.urlsafe_b64decode(bytes(map(ord, file_name))))).decode('utf-8')

    # 加密文件，分块加密文件，可以选择分割为小文件保存加密后的数据
    # 分块加密文件，每次加密block_size
    def encrypt_file(self, file_path, output_file_path):
        block_size = self.read_kb * 1024
        file_len = os.path.getsize(file_path)
        with open(file_path, 'rb') as f:
            read = 0
            while True:
                data = f.read(block_size)
                if not data:
                    break
                read += len(data)
                # 如果文件长度不是self.multiple_of_byte的整数倍则需要在尾部填充
                if read == file_len:
                    data = self.pad(data)
                with open(output_file_path, 'ab') as out:
                    out.write(self.chipher.encrypt(data))

    # 解密文件
    # 分块解密文件，每次解密block_size
    def decrypt_file(self, file_path, output_file_path):
        block_size = self.read_kb * 1024
        file_len = os.path.getsize(file_path)
        with open(file_path, 'rb') as f:
            read = 0
            while True:
                data = f.read(block_size)
                if not data:
                    break
                read += len(data)
                # 对最后一个文件块删除尾部填充的字节
                file_bytes = self.chipher.decrypt(data)
                if read == file_len:
                    file_bytes = self.unpad(file_bytes)
                with open(output_file_path, 'ab') as out:
                    out.write(file_bytes)

    # 加密文件，分块加密文件，可以选择分割为小文件保存加密后的数据
    # 分块加密文件，每次加密block_size
    # 分割保存的文件每一个大小为file_split_size KB，file_split_size须为block_size的整数倍
    def encrypt_split(self, file_path, output_file_path, file_split_kb=30720):
        block_size = self.read_kb * 1024
        file_len = os.path.getsize(file_path)
        with open(file_path, 'rb') as f:
            suffix = 1
            write_kb = 0
            out = open(output_file_path + '.' + str(suffix), 'wb')
            read = 0
            while True:
                data = f.read(block_size)
                if not data:
                    break
                read += len(data)
                # 如果文件长度不是self.multiple_of_byte的整数倍则需要在尾部填充
                if read == file_len:
                    data = self.pad(data)
                if write_kb >= file_split_kb:
                    suffix += 1
                    out.close()
                    out = open(output_file_path + '.' + str(suffix), 'ab')
                    write_kb = self.read_kb
                else:
                    write_kb += self.read_kb
                out.write(self.chipher.encrypt(data))
            out.close()

    # 解密文件
    # separate_count为分割文件的数量
    # 分块解密文件，每次解密block_size
    def decrypt_split(self, file_path, output_file_path, separate_count):
        block_size = self.read_kb * 1024
        file_len = 0
        for x in range(0, separate_count):
            file_len += os.path.getsize(file_path + '.' + str(x + 1))
        read = 0
        for x in range(0, separate_count):
            with open(file_path + '.' + str(x + 1), 'rb') as f:
                while True:
                    data = f.read(block_size)
                    if not data:
                        break
                    read += len(data)
                    # 对最后一个文件块删除尾部填充的字节
                    file_bytes = self.chipher.decrypt(data)
                    if read == file_len:
                        file_bytes = self.unpad(file_bytes)
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
