#上下文指针
#3.4节
class MyClass
  def initialize
    @v = 1
  end
end

#instance_eval方法的块能直接深入对象中，对其进行操作
obj = MyClass.new
obj.instance_eval do
  puts self
  puts @v
end

v = 2
obj.instance_eval { @v = v }
obj.instance_eval { puts @v }

#instance_exec是带参数的instance_eval
obj.instance_exec(3) do |arg| 
  @v = @v + arg 
  puts @v
end

#不使用instance_eval，需要扩展类才能达到同样目的
#仅仅是测试用，使用instance_eval能比较方便的将代码注入对象中。
class MyClass
  def puts_v
    puts @v
  end

  def change_v v
    @v = v
  end
end

obj.change_v v
obj.puts_v
