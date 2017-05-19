from CFCrypto import *
import filecmp

if True:
    # 使用DES加密解密的演示
    my_des = DESCrypto('hello')
    my_des.encrypt('f:/test.jpg', 'f:/test.jpg.des')
    my_des.decrypt('f:/test.jpg.des', 'f:/test2.jpg')

    if filecmp.cmp('f:/test.jpg', 'f:/test2.jpg'):
        print("same files!")

if True:
    # 使用AES加密解密的演示
    my_aes = AESCrypto('thisisverylongpasswordtotestaescrypto')
    my_aes.encrypt('f:/test.jpg', 'f:/test.jpg.aes')
    my_aes.decrypt('f:/test.jpg.aes', 'f:/test2.jpg')

    if filecmp.cmp('f:/test.jpg', 'f:/test2.jpg'):
        print("same files!")

if True:
    # 使用RSA加密解密的演示
    my_rsa = RSACrypto()

    # 如果首次加密，本地没有私钥文件和公钥文件，则需要生成
    # my_rsa.set_password('helloRSA')
    # my_rsa.set_public_key_path('./my_rsa.pub')
    # my_rsa.set_private_key_path('./my_rsa')
    # my_rsa.generate_key()

    # 使用RSA加密需要用到公钥文件
    my_rsa.set_public_key_path('./my_rsa.pub')
    my_rsa.encrypt('f:/test.jpg', 'f:/test.bin')

    # 使用RSA解密需要用到私钥密码和私钥文件
    my_rsa.set_password('helloRSA')
    my_rsa.set_private_key_path('./my_rsa')
    my_rsa.decrypt('f:/test.bin', 'f:/output.jpg')

    if filecmp.cmp('f:/test.jpg', 'f:/output.jpg'):
        print("same files!")