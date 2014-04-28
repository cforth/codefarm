#encoding:utf-8

#探索self
class MyClass

  #testing_self
  def testing_self
    @var = 10     #self的一个实体变量
    my_method()   #跟self.my_method()相同
    self
  end

  def my_method
    @var = @var + 1
  end

  def var
    @var
  end
end

#测试方法在执行中作为self的接收者

puts "\n"
puts "obj对象为MyClass类：#{obj = MyClass.new}"
puts "obj对象的testing_self方法没有执行前，实例变量没有初始化："
puts "obj中的实例变量为 #{obj.instance_variables}, 实例变量的值为 #{obj.var}"
puts "执行testing_self方法后，返回接收者 #{obj.testing_self}"  # => #<MyClass:0x510b44 @var=11>
puts "现在obj对象中的实例变量为 #{obj.instance_variables}, 实例变量的值为 #{obj.var}"
puts "\n"
