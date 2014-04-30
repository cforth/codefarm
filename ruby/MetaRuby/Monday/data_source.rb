#历史遗留问题模拟
#2.1节

#包含mysql驱动
require "mysql"

#历史数据库类
#用的是'tzfx'这个数据库
class DS

  def initialize
    @client = Mysql.real_connect('localhost','cf','123456','tzfx')
    @client.query("set names utf8;")
  end

  def get_dxt_question(id)
    sql = "SELECT * FROM dxt WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      puts "#{row[0]},#{row[1]}\n"
    end
  end

  def get_dxt_answer(id)
    sql = "SELECT * FROM dxt WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      puts "#{row[0]},#{row[2]}\n"
    end
  end

  def get_duo_question(id)
    sql = "SELECT * FROM duo WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      puts "#{row[0]},#{row[1]}\n"
    end
  end

  def get_duo_answer(id)
    sql = "SELECT * FROM duo WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      puts "#{row[0]},#{row[2]}\n"
    end
  end

  def get_pdt_question(id)
    sql = "SELECT * FROM pdt WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      puts "#{row[0]},#{row[1]}\n"
    end
  end

  def get_pdt_answer(id)
    sql = "SELECT * FROM pdt WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      puts "#{row[0]},#{row[2]}\n"
    end
  end

end


ds = DS.new
puts ds.get_pdt_question(10)
puts ds.get_pdt_answer(10)
