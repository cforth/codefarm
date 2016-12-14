import os
def swap_extensions(dir, before, after):
    if before[:1] != '.': #如果参数中的后缀名没有'.'则加上
        before = '.' + before
    thelen = -len(before)
    if after[:1] != '.':
        after = '.' + after
    for path, subdir, files in os.walk(dir):
        for oldfile in files:
            if oldfile[thelen:] == before:
                oldfile = os.path.join(path, oldfile)
                newfile = oldfile[:thelen] + after
                os.rename(oldfile, newfile)
                print(oldfile +' changed to ' + newfile)



if __name__ == '__main__':
    swap_extensions('F:/temp/111', '.pdf', '.PDF')
