#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import time
import shutil
import zipfile


def get_zip_file(input_path, result):
    files = os.listdir(input_path)
    for file in files:
        if os.path.isdir(input_path + '/' + file):
            get_zip_file(input_path + '/' + file, result)
        else:
            result.append(input_path + '/' + file)


def zip_file_path(input_path, output_path, output_name):
    f = zipfile.ZipFile(output_path + '/' + output_name, 'w', zipfile.ZIP_DEFLATED)
    file_lists = []
    get_zip_file(input_path, file_lists)
    for file in file_lists:
        f.write(file)
    f.close()
    return output_path + r"/" + output_name


if __name__ == '__main__':
    now_year = time.strftime("%Y{y}", time.localtime()).format(y='年', )
    now_date = time.strftime("%m{m}%d{d}", time.localtime()).format(m='月', d='日')
    zip_file_path(r"./data/"+now_year+"/"+now_date, './data/back/', now_date+".zip")
    # shutil.rmtree(r"./data/2020年/10月20日")
