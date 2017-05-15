from CFCrypto import RSACrypto


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