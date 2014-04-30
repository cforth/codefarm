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
      result = row[1] 
    end
    result
  end

  def get_dxt_answer(id)
    sql = "SELECT * FROM dxt WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      result = row[2]
    end
    result
  end

  def get_duo_question(id)
    sql = "SELECT * FROM duo WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      result = row[1] 
    end
    result
  end

  def get_duo_answer(id)
    sql = "SELECT * FROM duo WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      result = row[2] 
    end
    result
  end

  def get_pdt_question(id)
    sql = "SELECT * FROM pdt WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      result = row[1] 
    end
    result
  end

  def get_pdt_answer(id)
    sql = "SELECT * FROM pdt WHERE id = #{id};"
    res = @client.query(sql)
    while row = res.fetch_row do
      result = row[2] 
    end
    result
  end

end

#动态方法
class Exam
  def initialize(exam_id, data_source)
    @id = exam_id
    @data_source = data_source
    data_source.methods.grep(/^get_(.*)_question$/) {Exam.define_component $1}
  end

  def self.define_component(name)
    define_method(name) {
      question = @data_source.send "get_#{name}_question", @id
      answer = @data_source.send "get_#{name}_answer", @id
      result = "#{name.capitalize}: #{question} #{answer}"
      result
    }
  end
end

#原方法
ds = DS.new
puts ds.get_dxt_question(10)
puts ds.get_dxt_answer(10)
puts "\n"

#使用动态方法
exam = Exam.new(10, DS.new)
puts exam.dxt

