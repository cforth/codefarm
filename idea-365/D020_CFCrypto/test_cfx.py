from CFX import *
import os
import filecmp
import unittest
import shutil


class TestCrypto(unittest.TestCase):
    def test_StringCrypto(self):
        iv = "UEr9si9EynusD5GGVuiqKw=="
        my_cipher = StringCrypto('this is password')
        string = 'this is a secret!!! 这是一个秘密！！！'
        ivv, encrypt_str = my_cipher.encrypt(string, iv)
        print(ivv, encrypt_str)
        decrypt_str = my_cipher.decrypt(encrypt_str, iv)
        self.assertEqual(string, decrypt_str)


if __name__ == '__main__':
    unittest.main()
