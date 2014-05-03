#演示proc与lambda
#3.5节 可调用对象
double = Proc.new {|x| x * 2}
inc = proc {|x| x + 1}
dec = lambda {|x| x - 1}

puts double.call 2
puts inc.call 2
puts dec.call 2


#&操作符
def math(a, b)
  yield(a , b)
end

def teach_math(a, b, &operation)
  puts "Let's do the math!"
  puts math(a, b, &operation)
end

teach_math(2, 3) {|x, y| x * y}

#
def my_method(&the_proc)
  the_proc
end

p = my_method {|name| "Hello, #{name}!"}
puts p.class
puts p.call("Bill")

#
def my_method2(greeting)
  puts "#{greeting}, #{yield}!"
end

my_proc = proc {"Bill"}
my_method2("Hello", &my_proc)
