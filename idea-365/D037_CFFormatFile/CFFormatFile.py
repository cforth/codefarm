import os
import hashlib


def generate_cf_format_file(file_path, output_dir, file_name=None):
    if not os.path.exists(file_path):
        raise ValueError('Input file path not exists: %s ', file_path)

    if not os.path.exists(output_dir):
        raise ValueError('Output file path not exists: %s ', output_dir)

    if not os.path.isfile(file_path):
        raise ValueError('Input file path not file: %s ', file_path)

    if not file_name:
        file_name = os.path.basename(file_path)

    file_name_bytes = file_name.encode('utf-8')

    md5 = hashlib.md5()
    md5.update(file_name_bytes)
    file_name_md5 = md5.hexdigest()

    with open(os.path.join(output_dir, file_name_md5), 'wb') as out_f:
        out_f.write(b'cf')
        file_name_length = len(file_name_bytes)
        name_length_str = ''
        for i in range(0, 4 - len(str(file_name_length))):
            name_length_str += '0'
        name_length_str += str(file_name_length)
        out_f.write(name_length_str.encode('utf-8'))
        out_f.write(file_name_bytes)

        with open(file_path, 'rb') as in_f:
            data = in_f.read()
            out_f.write(data)


def parse_cf_format_file(file_path):
    with open(file_path, 'rb') as f:
        file_format = f.read(2)
        if file_format == b'cf':
            print("CF Format File")
            name_length = int(f.read(4).decode('utf-8'))
            print(name_length)
            name = f.read(name_length).decode('utf-8')
            print(name)


def extract_cf_format_file(file_path, output_dir):
    with open(file_path, 'rb') as f:
        file_format = f.read(2)
        if file_format == b'cf':
            print("CF Format File")
            name_length = int(f.read(4).decode('utf-8'))
            print(name_length)
            name = f.read(name_length).decode('utf-8')
            print(name)
            data = f.read()
            with open(os.path.join(output_dir, name), 'wb') as out_f:
                out_f.write(data)
