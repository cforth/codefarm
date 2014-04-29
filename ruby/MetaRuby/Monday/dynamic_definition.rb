#动态定义方法
#2.2节

class MyClass
  define_method :my_method do |my_arg|
    my_arg * 3
  end
end

obj = MyClass.new
puts "#{obj.my_method(2)}"
