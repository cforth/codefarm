import time
import re
import random
from selenium import webdriver

# 打开浏览器，关闭弹出通知
options = webdriver.ChromeOptions()
prefs = {
    'profile.default_content_setting_values':
        {
            'notifications': 2
        }
}
options.add_experimental_option('prefs', prefs)
# executable_path中放入所需要的chromedriver，网上下载
wb = webdriver.Chrome(executable_path="./driver/chromedriver.exe", chrome_options=options)

# 设置浏览器反应时间
wb.implicitly_wait(10)

# 设置窗口最大化
wb.maximize_window()

# 设置访问的网站，微博需要先打开首页，再打开实时热点，不然无法获取到实时热点
url = 'https://weibo.com/'
wb.get(url)

# wb.find_element_by_id('pl_unlogin_home_hots').find_elements_by_class_name("UG_box_foot")[1].click()

time.sleep(10)
wb.get("https://weibo.com/a/hot/realtime")

now_year = time.strftime("%Y{y}", time.localtime()).format(y='年',)
now_date = time.strftime("%m{m}%d{d}", time.localtime()).format(m='月', d='日')
print(now_date)
# 将实时热点主网页存入文件中, 自建日期文件夹，防止误操作，格式为 10月18日
with open("./data/" + now_year + "/" + now_date + "/main.html", 'wb') as f:
    f.write(wb.page_source.encode("utf-8", "ignore"))  # 忽略非法字符
    print('写入成功')

# 获取所有热点的子网页链接
with open("./data/" + now_year + "/" + now_date + "/main.html", 'r', encoding="utf-8") as f:
    redian_text = f.read()

pattern = re.compile(r'<h3 class="list_title_b">(.*)</h3>')
href_pattern = re.compile(r'href="(.*)\?type=grab"')
href_list = pattern.findall(redian_text)

index = 0
for zi_href in href_list:
    index += 1
    r_href = "https://weibo.com/a/hot/" + href_pattern.findall(zi_href)[0]
    wb.get(r_href)
    time.sleep(random.randint(5, 10))
    # 将当日实时热点的子网页存入文件中
    with open("./data/" + now_year + "/" + now_date + "/" + str(index) + ".html", 'wb') as f:
        f.write(wb.page_source.encode("utf-8", "ignore"))  # 忽略非法字符
        print('写入成功' + str(index))
