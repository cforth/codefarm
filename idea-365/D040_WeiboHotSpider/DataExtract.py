#!/usr/bin/env python
# -*- coding: utf-8 -*-
import re
import os
from libs.ORM import *


class DailyHotNews(Model):
    # 定义类的属性到列的映射：
    title = StringField('title')
    content = StringField('content')
    author = StringField('author')
    date = StringField('date')


# 处理文件夹
def dir_handle(data_dir):
    data_dir_path = os.path.abspath(data_dir)
    print(data_dir_path)

    for path, subdir, files in os.walk(data_dir_path):
        for f in files:
            hot_html = os.path.join(path, f)
            if hot_html.find("main") == -1:
                save_in_sqlite(*extract(hot_html))


# 处理数据，网页保存的路径格式为 data/2020年/10月18日/***.html
def extract(hot_news_html_path):
    # 匹配热点标题
    title_pattern = re.compile(r'<h2 class="list_title">(.*?)</h2>', re.DOTALL)
    # 匹配热点内容
    content_pattern = re.compile(r'<div class="list_des">(.*?)</div>', re.DOTALL)
    # 匹配热点的作者和日期时间
    author_date_time_pattern = re.compile(r'<span class="subinfo S_txt2">(.*?)</span>', re.DOTALL)

    with open(hot_news_html_path, 'r', encoding="utf-8") as hf:
        dir_date = os.path.basename(os.path.dirname(hot_news_html_path))
        hot_news_text = hf.read()
        # 获取热点的标题
        title = title_pattern.findall(hot_news_text)
        title = title[0].strip() if title else "No Title"
        print("Title: " + title)
        # 获取热点内容
        content = content_pattern.findall(hot_news_text)
        content = content[0].strip() if title else "No Content"
        print("Content: " + content)
        # 获取热点作者
        author_date_time = author_date_time_pattern.findall(hot_news_text)
        author = author_date_time[0].strip() if author_date_time else "No author"
        print("Author: " + author)
        # 获取日期和时间
        date_time = author_date_time[1].strip() if author_date_time else "No date and time"
        date_time = date_time if date_time.find("今天") == -1 else date_time.replace("今天", dir_date)
        print("Date Time: " + date_time)
        print("\n\n")
        return title, content, author, date_time


# 存入数据库文件
def save_in_sqlite(title, content, author, date_time):
    # 新建数据库和数据表
    if not DailyHotNews.has_table():
        DailyHotNews.new_table()
    news = DailyHotNews(title=title, content=content, author=author, date=date_time)
    news.save()


dir_handle("./data/2020年")
