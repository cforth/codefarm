##
# 打开已有的String类

class String
  ##
  # 删除字符串中的标点符号和特殊字符，只保留字母、数字和空格

  def to_alphanumeric
    gsub /[^\w\s]/, ''
  end

end

##
# 包含单元测试模块

require 'test/unit'

##
#单元测试

class ToAlphanumericTest < Test::Unit::TestCase
  
  ##
  # 测试to_alphanumeric方法的正确性
  def test_strips_non_alphanumeric_characters
    assert_equal '3 the Magic Number ', '#3, the *Magic, Number* ?'.to_alphanumeric
  end

end
