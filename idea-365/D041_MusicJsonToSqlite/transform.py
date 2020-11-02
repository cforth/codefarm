import json
from CryptoFactory.ORM import *


class MusicInfo(Model):
    # 定义类的属性到列的映射：
    id = IntegerField('id', primary_key=True)
    music_name = StringField('music_name')
    music_star = StringField('music_star')
    play_count = IntegerField('play_count')
    tag = StringField('tag')


def read_from_json(json_path):
    music_play_times_dict = {}
    star_index_path_list = []
    if os.path.exists(json_path):
        with open(json_path, "r") as f:
            music_info = json.load(f)
            if music_info.get("music_play_times_dict"):
                music_play_times_dict = music_info.get("music_play_times_dict")
            if music_info.get("star_index_path_list"):
                star_index_path_list = music_info.get("star_index_path_list")

    # 新建数据库和数据表
    if not MusicInfo.has_table():
        MusicInfo.new_table()

    for k, v in music_play_times_dict.items():
        if k in star_index_path_list:
            music_star = "true"
        else:
            music_star = "false"
        m = MusicInfo(music_name=k, music_star=music_star, play_count=v, tag="")
        m.save()


read_from_json("2cc99dd79dac4bba674e11560d4612d4.json")
