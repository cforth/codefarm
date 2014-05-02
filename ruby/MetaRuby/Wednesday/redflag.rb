#领域专属语言
#3.6节
def event(name)
  puts "ALERT: #{name}" if yield
end
Dir.glob('*events.rb').each {|file| load file}
