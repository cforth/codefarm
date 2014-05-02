#DSL测试
#3.6节
def monthly_sales
  110 #TODO: 从数据库中读取真实的数据
end

target_sales = 100

event "monthly sales are suspiciously high" do
  monthly_sales > target_sales
end

event "monthly sales are abysmally low" do
  monthly_sales < target_sales
end
