#为Array类添加replace方法
#raplace会覆盖已有的replace方法，所以需要更改名称
class Array
  #replace2

  def replace2(from, to)
    each_with_index do |e, i|
      self[i] = to if e == from
    end
  end
end

# 包含单元测试模块

require 'test/unit'

#单元测试

class Replace2Test < Test::Unit::TestCase
  
  # 测试replace方法的正确性
  def test_replace2
    book_topics = ['html', 'java', 'css']
    book_topics.replace2('java', 'ruby')
    expected = ['html', 'ruby', 'css']
    assert_equal expected, book_topics
  end

end
