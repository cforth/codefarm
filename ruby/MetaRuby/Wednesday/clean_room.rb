#洁净室
#创建一个对象，仅为了在其中执行块
#3.4节

class CleanRoom
  def complex_calculation
    @v = 11
  end

  def do_something
    puts @v
  end
end

#洁净室这个环境暴露若干有用的方法供块调用
clean_room = CleanRoom.new
clean_room.instance_eval do
  if complex_calculation > 10
    do_something
  end
end
