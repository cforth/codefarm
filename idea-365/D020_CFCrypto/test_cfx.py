from CFX import *
import os
import filecmp
import unittest
import shutil


class TestCrypto(unittest.TestCase):
    def test_StringCrypto(self):
        iv_str = "UEr9si9EynusD5GGVuiqKw=="
        original_string = 'this is a secret!!! 这是一个秘密！！！'
        my_cipher = StringCrypto('this is password', iv_str)
        encrypt_str = my_cipher.encrypt(original_string)
        decrypt_str = my_cipher.decrypt(encrypt_str)
        print(my_cipher.iv_str)
        self.assertEqual(encrypt_str, 'p27dj7RbfYbv1R8+NJJmQ5cjHacSKCBYAWa0Mx1QASUpA2BRxja0VelGCC33VS36')
        self.assertEqual(original_string, decrypt_str)
        my_cipher = StringCrypto('this is password', iv_str, use_md5=True)
        encrypt_str = my_cipher.encrypt(original_string)
        decrypt_str = my_cipher.decrypt(encrypt_str)
        self.assertEqual(encrypt_str, 'Zd4q3Fj/rwMGJIxNBUYMttGQM9hr8QgKGrQ4KZz1G2VtI4B67I5pk3/mw8GtPyX0')
        self.assertEqual(original_string, decrypt_str)
        my_cipher = StringCrypto('this is password', iv_str, use_md5=True, use_urlsafe=True)
        encrypt_str = my_cipher.encrypt(original_string)
        decrypt_str = my_cipher.decrypt(encrypt_str)
        self.assertEqual(original_string, decrypt_str)
        self.assertEqual(encrypt_str, 'Zd4q3Fj_rwMGJIxNBUYMttGQM9hr8QgKGrQ4KZz1G2VtI4B67I5pk3_mw8GtPyX0')
        my_cipher = StringCrypto('this is password', iv_str, use_md5=True, use_urlsafe=True)
        encrypt_str = my_cipher.encrypt(original_string)
        print(iv_str)
        print(encrypt_str)
        decrypt_str = my_cipher.decrypt(encrypt_str)
        self.assertEqual(original_string, decrypt_str)

    def test_ByteCrypto(self):
        my_cipher = ByteCrypto('this is very long password to test file crypto')
        with open('./testdata/test.png', 'rb') as f_from:
            encrypt_data = my_cipher.encrypt(f_from.read())
            print(my_cipher.iv_str)
            with open('./testdata/test.png.aes', 'wb') as f_to:
                f_to.write(encrypt_data)

        with open('./testdata/test.png.aes', 'rb') as f_from:
            decrypt_data = my_cipher.decrypt(f_from.read())
            print(my_cipher.iv_str)
            with open('./testdata/aes_test.png', 'wb') as f_to:
                f_to.write(decrypt_data)

        self.assertTrue(filecmp.cmp('./testdata/test.png', './testdata/aes_test.png'))
        os.remove('./testdata/aes_test.png')
        os.remove('./testdata/test.png.aes')

    def test_FileCrypto(self):
        my_cipher = FileCrypto('this is very long password to test file crypto')
        my_cipher.encrypt('./testdata/test.pdf', './testdata/test.pdf.aes')
        print(my_cipher.iv_str)
        my_cipher.decrypt('./testdata/test.pdf.aes', './testdata/aes_test.pdf')
        self.assertTrue(filecmp.cmp('./testdata/test.pdf', './testdata/aes_test.pdf'))
        os.remove('./testdata/aes_test.pdf')
        os.remove('./testdata/test.pdf.aes')
        iv_str = "UEr9si9EynusD5GGVuiqKw=="
        my_cipher = FileCrypto('this is very long password to test file crypto', iv_str)
        my_cipher.encrypt('./testdata/test.pdf', './testdata/test.pdf.aes')
        print(my_cipher.iv_str)
        my_cipher.decrypt('./testdata/test.pdf.aes', './testdata/aes_test.pdf')
        self.assertTrue(filecmp.cmp('./testdata/test.pdf', './testdata/aes_test.pdf'))
        os.remove('./testdata/aes_test.pdf')
        os.remove('./testdata/test.pdf.aes')

    def test_BigFileCrypto(self):
        # 使用AES加密解密的演示,指定iv_str
        iv_str = "UEr9si9EynusD5GGVuiqKw=="
        password = 'this is very long password to test file crypto'
        my_cipher = FileCrypto(password, iv_str)
        my_cipher.encrypt('./testdata/test.mp4', './testdata/test.mp4.aes')
        print(my_cipher.iv_str)
        my_cipher.decrypt('./testdata/test.mp4.aes', './testdata/aes_test.mp4')
        self.assertTrue(filecmp.cmp('./testdata/test.mp4', './testdata/aes_test.mp4'))
        os.remove('./testdata/aes_test.mp4')
        os.remove('./testdata/test.mp4.aes')

    def test_DirCrypto(self):
        iv_str = "UEr9si9EynusD5GGVuiqKw=="
        password = 'this is very long password to test file crypto'
        my_cipher = DirFileCrypto(password, iv_str)
        my_cipher.encrypt('./testdata/testdir/', './testdata/')
        print(my_cipher.iv_str)
        my_cipher.decrypt('./testdata/5OiNg8Gq2qWsdob6u5jlhg==/', './testdata/testdecrytdir/')
        self.assertTrue(filecmp.cmp('./testdata/testdir/test.mp3', './testdata/testdecrytdir/testdir/test.mp3'))
        shutil.rmtree('./testdata/testdecrytdir')
        shutil.rmtree('./testdata/5OiNg8Gq2qWsdob6u5jlhg==')

    def test_ListCrypto(self):
        iv_str = "UEr9si9EynusD5GGVuiqKw=="
        password = 'this is very long password to test file crypto'
        my_cipher = ListCrypto(password, iv_str)
        my_cipher.encrypt(['./testdata/test.pdf', './testdata/testdir/', './testdata/test.png'], './testdata/testlist/')
        print(my_cipher.iv_str)
        my_cipher.decrypt(['./testdata/testlist/EQxPeHaoSakp41HUzNLAmQ==', './testdata/testlist/5OiNg8Gq2qWsdob6u5jlhg==/', './testdata/testlist/rrGDhLKxkcB4oTH4ezLOKA=='], './testdata/testdecrytlist/')
        self.assertTrue(filecmp.cmp('./testdata/testdir/test.mp3', './testdata/testdecrytlist/testdir/test.mp3'))
        shutil.rmtree('./testdata/testdecrytlist')
        shutil.rmtree('./testdata/testlist')


if __name__ == '__main__':
    unittest.main()
