from CFX import *
import os
import filecmp
import unittest
import shutil


class TestCrypto(unittest.TestCase):
    def test_StringCrypto(self):
        iv = "UEr9si9EynusD5GGVuiqKw=="
        string = 'this is a secret!!! 这是一个秘密！！！'
        my_cipher = StringCrypto('this is password')
        ivv, encrypt_str = my_cipher.encrypt(string, iv)
        ivv, decrypt_str = my_cipher.decrypt(encrypt_str, iv)
        self.assertEqual(encrypt_str, 'p27dj7RbfYbv1R8+NJJmQ5cjHacSKCBYAWa0Mx1QASUpA2BRxja0VelGCC33VS36')
        self.assertEqual(string, decrypt_str)
        my_cipher = StringCrypto('this is password', use_md5=True)
        ivv, encrypt_str = my_cipher.encrypt(string, iv)
        ivv, decrypt_str = my_cipher.decrypt(encrypt_str, iv)
        self.assertEqual(encrypt_str, 'Zd4q3Fj/rwMGJIxNBUYMttGQM9hr8QgKGrQ4KZz1G2VtI4B67I5pk3/mw8GtPyX0')
        self.assertEqual(string, decrypt_str)
        my_cipher = StringCrypto('this is password', use_md5=True, use_urlsafe=True)
        ivv, encrypt_str = my_cipher.encrypt(string, iv)
        ivv, decrypt_str = my_cipher.decrypt(encrypt_str, iv)
        self.assertEqual(string, decrypt_str)
        self.assertEqual(encrypt_str, 'Zd4q3Fj_rwMGJIxNBUYMttGQM9hr8QgKGrQ4KZz1G2VtI4B67I5pk3_mw8GtPyX0')
        my_cipher = StringCrypto('this is password', use_md5=True, use_urlsafe=True)
        ivv, encrypt_str = my_cipher.encrypt(string)
        print(ivv, encrypt_str)
        ivv, decrypt_str = my_cipher.decrypt(encrypt_str, ivv)
        self.assertEqual(string, decrypt_str)

    def test_ByteCrypto(self):
        my_aes = ByteCrypto('this is very long password to test file crypto')
        with open('./testdata/test.png', 'rb') as f_from:
            iv_str, my_data = my_aes.encrypt(f_from.read())
            print(iv_str)
            with open('./testdata/test.png.aes', 'wb') as f_to:
                f_to.write(my_data)

        with open('./testdata/test.png.aes', 'rb') as f_from:
            iv_str, my_dedata = my_aes.decrypt(f_from.read(), iv_str)
            print(iv_str)
            with open('./testdata/aes_test.png', 'wb') as f_to:
                f_to.write(my_dedata)

        self.assertTrue(filecmp.cmp('./testdata/test.png', './testdata/aes_test.png'))
        os.remove('./testdata/aes_test.png')
        os.remove('./testdata/test.png.aes')

    def test_FileCrypto(self):
        my_aes = FileCrypto('this is very long password to test file crypto')
        iv_str = my_aes.encrypt('./testdata/test.pdf', './testdata/test.pdf.aes')
        print(iv_str)
        iv_str = my_aes.decrypt('./testdata/test.pdf.aes', './testdata/aes_test.pdf', iv_str)
        print(iv_str)
        self.assertTrue(filecmp.cmp('./testdata/test.pdf', './testdata/aes_test.pdf'))
        os.remove('./testdata/aes_test.pdf')
        os.remove('./testdata/test.pdf.aes')

        # 使用AES加密解密的演示,指定iv_str
        iv_str = "UEr9si9EynusD5GGVuiqKw=="
        my_aes = FileCrypto('this is very long password to test file crypto')
        iv_str = my_aes.encrypt('./testdata/test.mp4', './testdata/test.mp4.aes', iv_str="UEr9si9EynusD5GGVuiqKw==")
        print(iv_str)
        iv_str = my_aes.decrypt('./testdata/test.mp4.aes', './testdata/aes_test.mp4', iv_str)
        print(iv_str)
        self.assertTrue(filecmp.cmp('./testdata/test.mp4', './testdata/aes_test.mp4'))
        os.remove('./testdata/aes_test.mp4')
        os.remove('./testdata/test.mp4.aes')


if __name__ == '__main__':
    unittest.main()
