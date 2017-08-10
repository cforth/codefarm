import os

def file_split(file_path, output_file_path, size):
    if not os.path.exists(file_path):
        raise ValueError('Input file path not exists: %s ', file_path)
    
    all_len = os.path.getsize(file_path)
    num = all_len // size if all_len % size == 0 else (all_len // size) + 1
    index = 0
    with open(file_path, 'rb') as f:
        for i in range(0, num):
            index += 1
            data = f.read(size)
            if not data:
                break
            with open(output_file_path + '.' + str(index), 'ab') as out:
                out.write(data)


def file_merge(file_path, output_file_path, num):
    if os.path.exists(output_file_path):
        raise ValueError('Output file path exists: %s ', output_file_path)

    with open(output_file_path, 'ab') as out:
        for i in range(1, num+1):
            with open(file_path + '.' + str(i), 'rb') as f:
                data = f.read()
                if not data:
                    break
                out.write(data)

file_split('E:/tt.zip', 'E:/xxx', 100*1024*1024)
file_merge('E:/xxx', 'E:/ttt.zip', 5)
