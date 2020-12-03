COMMAND_PATTERN = /^:([connect|message|exit])(.*)/

def routes(line="")
  puts line
  if line.match? COMMAND_PATTERN
    puts "@@"
    puts line.split()


  # if x > 2
  #   puts "x 大于 2"
  # elsif x <= 2 and x!=0
  #   puts "x 是 1"
  # else
  #   puts "无法得知 x 的值"
  end

end