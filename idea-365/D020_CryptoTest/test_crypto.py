from CFCrypto import *
import filecmp
import unittest


class TestCFCryto(unittest.TestCase):

    def test_des(self):
        # 使用DES加密解密的演示
        my_des = DESCrypto('hello')
        my_des.encrypt('./test.jpg', './test.jpg.des')
        my_des.decrypt('./test.jpg.des', './destest.jpg')
        self.assertTrue(filecmp.cmp('./test.jpg', './destest.jpg'))
        os.remove('./destest.jpg')
        os.remove('./test.jpg.des')

    def test_aes(self):
        # 使用AES加密解密的演示
        my_aes = AESCrypto('thisisverylongpasswordtotestaescrypto')
        my_aes.encrypt('./test.jpg', './test.jpg.aes')
        my_aes.decrypt('./test.jpg.aes', './aestest.jpg')
        self.assertTrue(filecmp.cmp('./test.jpg', './aestest.jpg'))
        os.remove('./aestest.jpg')
        os.remove('./test.jpg.aes')

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