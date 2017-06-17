from CFCrypto import *
import os
import filecmp
import unittest
import shutil


class TestCrypto(unittest.TestCase):
    def test_StringCrypto(self):
        my_cipher = StringCrypto('this is password')
        string = 'this is a secret!!! 这是一个秘密！！！'
        encrypt_str = my_cipher.encrypt(string)
        decrypt_str = my_cipher.decrypt(encrypt_str)
        self.assertEqual(string, decrypt_str)

    def test_FileCrypto(self):
        # 使用AES加密解密的演示
        my_aes = FileCrypto('this is very long password to test file crypto')
        my_aes.encrypt('./testdata/test.jpg', './testdata/test.jpg.aes')
        my_aes.decrypt('./testdata/test.jpg.aes', './testdata/aes_test.jpg')
        self.assertTrue(filecmp.cmp('./testdata/test.jpg', './testdata/aes_test.jpg'))
        os.remove('./testdata/aes_test.jpg')
        os.remove('./testdata/test.jpg.aes')
        my_aes.encrypt('./testdata/test.mp3', './testdata/test.mp3.aes')
        my_aes.decrypt('./testdata/test.mp3.aes', './testdata/aes_test.mp3')
        self.assertTrue(filecmp.cmp('./testdata/test.mp3', './testdata/aes_test.mp3'))
        os.remove('./testdata/aes_test.mp3')
        os.remove('./testdata/test.mp3.aes')

    def test_DirCrypto(self):
        my_cipher = DirFileCrypto('crypto dir')
        my_cipher.encrypt('./testdata/', './en_data/')
        my_cipher.decrypt('./en_data/testdata/', './de_data/')
        self.assertTrue(filecmp.cmp('./de_data/testdata/test.mp3', './testdata/test.mp3'))
        self.assertTrue(filecmp.cmp('./de_data/testdata/测试中文目录名/test.txt', './testdata/测试中文目录名/test.txt'))
        dir_cipher = DirNameCrypto('crypto dir')
        dir_cipher.encrypt('./en_data/testdata')
        dir_cipher.decrypt('./en_data/testdata')
        self.assertTrue(os.path.exists('./en_data/testdata/测试中文目录名/empytdir'))
        shutil.rmtree('./en_data')
        shutil.rmtree('./de_data')

    def test_RSACrypto(self):
        # 使用RSA加密解密的演示
        my_rsa = RSACrypto()
        # 如果首次加密，本地没有私钥文件和公钥文件，则需要生成
        my_rsa.set_password('helloRSA')
        my_rsa.set_public_key_path('./testdata/my_rsa.pub')
        my_rsa.set_private_key_path('./testdata/my_rsa')
        my_rsa.generate_key()
        # 使用RSA加密需要用到公钥文件
        my_rsa.set_public_key_path('./testdata/my_rsa.pub')
        my_rsa.encrypt('./testdata/test.jpg', './testdata/test.bin')
        # 使用RSA解密需要用到私钥密码和私钥文件
        my_rsa.set_password('helloRSA')
        my_rsa.set_private_key_path('./testdata/my_rsa')
        my_rsa.decrypt('./testdata/test.bin', './testdata/output.jpg')
        self.assertTrue(filecmp.cmp('./testdata/test.jpg', './testdata/output.jpg'))
        os.remove('./testdata/output.jpg')
        os.remove('./testdata/test.bin')
        os.remove('./testdata/my_rsa.pub')
        os.remove('./testdata/my_rsa')


if __name__ == '__main__':
    unittest.main()