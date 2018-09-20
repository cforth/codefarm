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


if __name__ == '__main__':
    unittest.main()
