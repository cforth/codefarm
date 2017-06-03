from CFCrypto import *
import os
import filecmp
import unittest


class TestCoolFileCrypto(unittest.TestCase):
    def test_aes(self):
        # 使用AES加密解密的演示
        # 请自行准备jpg、MP3文件测试
        my_aes = CoolFileCrypto('thisisverylongpasswordtotestaescrypto')
        my_aes.encrypt('./test.jpg', './test.jpg.aes')
        my_aes.decrypt('./test.jpg.aes', './aestest.jpg')
        self.assertTrue(filecmp.cmp('./test.jpg', './aestest.jpg'))
        os.remove('./aestest.jpg')
        os.remove('./test.jpg.aes')
        my_aes.encrypt('./test.mp3', './test.mp3.aes')
        my_aes.decrypt('./test.mp3.aes', './aestest.mp3')
        self.assertTrue(filecmp.cmp('./test.mp3', './aestest.mp3'))
        os.remove('./aestest.mp3')
        os.remove('./test.mp3.aes')

    def test_aes_split(self):
        # 使用AES加密解密的演示
        my_aes = CoolFileCrypto('thisisverylongpasswordtotestaescrypto')
        my_aes.encrypt_split('./test.jpg', './test.jpg.aes')
        my_aes.decrypt_split('./test.jpg.aes', './aestest.jpg', 1)
        self.assertTrue(filecmp.cmp('./test.jpg', './aestest.jpg'))
        os.remove('./aestest.jpg')
        os.remove('./test.jpg.aes.1')
        my_aes.encrypt_split('./test.mp3', './test.mp3.aes')
        my_aes.decrypt_split('./test.mp3.aes', './aestest.mp3', 3)
        self.assertTrue(filecmp.cmp('./test.mp3', './aestest.mp3'))
        os.remove('./aestest.mp3')
        os.remove('./test.mp3.aes.1')
        os.remove('./test.mp3.aes.2')
        os.remove('./test.mp3.aes.3')

    def test_des(self):
        # 使用DES加密解密的演示
        my_des = CoolFileCrypto('hello', 'DES')
        my_des.encrypt('./test.jpg', './test.jpg.des')
        my_des.decrypt('./test.jpg.des', './destest.jpg')
        self.assertTrue(filecmp.cmp('./test.jpg', './destest.jpg'))
        os.remove('./destest.jpg')
        os.remove('./test.jpg.des')
        my_des.encrypt('./test.mp3', './test.mp3.des')
        my_des.decrypt('./test.mp3.des', './destest.mp3')
        self.assertTrue(filecmp.cmp('./test.mp3', './destest.mp3'))
        os.remove('./destest.mp3')
        os.remove('./test.mp3.des')

    def test_des_split(self):
        # 使用DES加密解密的演示
        my_des = CoolFileCrypto('hello', 'DES')
        my_des.encrypt_split('./test.jpg', './test.jpg.des')
        my_des.decrypt_split('./test.jpg.des', './destest.jpg', 1)
        self.assertTrue(filecmp.cmp('./test.jpg', './destest.jpg'))
        os.remove('./destest.jpg')
        os.remove('./test.jpg.des.1')
        my_des.encrypt_split('./test.mp3', './test.mp3.des')
        my_des.decrypt_split('./test.mp3.des', './destest.mp3', 3)
        self.assertTrue(filecmp.cmp('./test.mp3', './destest.mp3'))
        os.remove('./destest.mp3')
        os.remove('./test.mp3.des.1')
        os.remove('./test.mp3.des.2')
        os.remove('./test.mp3.des.3')


class TestRSACrypto(unittest.TestCase):
    def test_rsa(self):
        # 使用RSA加密解密的演示
        my_rsa = RSACrypto()
        # 如果首次加密，本地没有私钥文件和公钥文件，则需要生成
        my_rsa.set_password('helloRSA')
        my_rsa.set_public_key_path('./my_rsa.pub')
        my_rsa.set_private_key_path('./my_rsa')
        my_rsa.generate_key()
        # 使用RSA加密需要用到公钥文件
        my_rsa.set_public_key_path('./my_rsa.pub')
        my_rsa.encrypt('./test.jpg', './test.bin')
        # 使用RSA解密需要用到私钥密码和私钥文件
        my_rsa.set_password('helloRSA')
        my_rsa.set_private_key_path('./my_rsa')
        my_rsa.decrypt('./test.bin', './output.jpg')
        self.assertTrue(filecmp.cmp('./test.jpg', './output.jpg'))
        os.remove('./output.jpg')
        os.remove('./test.bin')
        os.remove('./my_rsa.pub')
        os.remove('./my_rsa')


if __name__ == '__main__':
    unittest.main()
