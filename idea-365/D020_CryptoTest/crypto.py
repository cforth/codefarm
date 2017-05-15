from Crypto.PublicKey import RSA
from Crypto.Random import get_random_bytes
from Crypto.Cipher import AES, PKCS1_OAEP


def genKey(passwd, private_key_path, public_key_path):
    key = RSA.generate(2048)
    encrypted_key = key.exportKey(passphrase=passwd, pkcs=8, protection="scryptAndAES128-CBC")
    with open(private_key_path, 'wb') as f:
        f.write(encrypted_key)
    with open(public_key_path, 'wb') as f:
        f.write(key.publickey().exportKey())


def cryto(file_path, cryto_file_path, public_key_path):
    with open(cryto_file_path, 'wb') as out_file:
        recipient_key = RSA.import_key(
            open(public_key_path).read())
        session_key = get_random_bytes(16)
        cipher_rsa = PKCS1_OAEP.new(recipient_key)
        out_file.write(cipher_rsa.encrypt(session_key))
        cipher_aes = AES.new(session_key, AES.MODE_EAX)
        with open(file_path, 'rb') as f:
            data = f.read()
        ciphertext, tag = cipher_aes.encrypt_and_digest(data)
        out_file.write(cipher_aes.nonce)
        out_file.write(tag)
        out_file.write(ciphertext)


def deCrypto(passwd, cryto_file_path, file_path, private_key_path):
    with open(cryto_file_path, 'rb') as fobj:
        private_key = RSA.import_key(
            open(private_key_path).read(),
            passphrase=passwd)
        enc_session_key, nonce, tag, ciphertext = [ fobj.read(x) 
                                                    for x in (private_key.size_in_bytes(), 
                                                    16, 16, -1) ]
        cipher_rsa = PKCS1_OAEP.new(private_key)
        session_key = cipher_rsa.decrypt(enc_session_key)
        cipher_aes = AES.new(session_key, AES.MODE_EAX, nonce)
        data = cipher_aes.decrypt_and_verify(ciphertext, tag)
    with open(file_path, 'wb') as f:
            f.write(data)



genKey('yourpasswd', 'f:/temp/my_private_rsa_key.bin', 'f:/temp/my_rsa_public.pem')
cryto('f:/temp/test.jpg', 'f:/temp/encrypted_data.bin', 'f:/temp/my_rsa_public.pem')
deCrypto('yourpasswd', 'f:/temp/encrypted_data.bin', 'f:/temp/decryto.jpg', 'f:/temp/my_private_rsa_key.bin')
