#练习Block基础知识
#3.1节

def a_method(a, b)
  a + yield(a, b)
end

 puts a_method(1, 2) {|x, y| (x + y) * 3}
