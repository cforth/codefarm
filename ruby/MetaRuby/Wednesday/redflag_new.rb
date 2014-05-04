#更好的DSL
#3.7节

#把event中的block保存为proc，连同字符串参数保存在哈希表中。
def event (name, &block)
  @events[name] = block
end

#把setup中的block保存到list中。
def setup(&block)
  @setups << block
end

#在每个测试文件上，保存setups和events。
#对于每个events，首先建立一个env对象作为洁净室。
#先运行所有的sets，然后再测试每个events。
Dir.glob('*events_new.rb').each do |file|
  @setups = []
  @events = {}
  load file
  @events.each_pair do |name, event|
    env = Object.new
    @setups.each do |setup|
      env.instance_eval &setup
    end
    puts "ALERT: #{name}" if env.instance_eval &event
  end
end
