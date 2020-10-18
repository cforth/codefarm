import time
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

# 将实时热点网页存入文件中
with open("weibiredian.html", 'wb') as f:
    f.write(wb.page_source.encode("utf-8", "ignore"))  # 忽略非法字符
    print('写入成功')

