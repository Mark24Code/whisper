require "time"


COMMAND_PATTERN = /^:([connect|message|exit])(.*?)/

def get_meta_info(raw_string)
  first_gap_index = raw_string.index(" ")
  command = raw_string[0..first_gap_index].strip
  content = raw_string[first_gap_index..].strip
  timestamp = Time.now.to_i

  return [timestamp, command, content]
end

def routes(line="")
  if line.match? COMMAND_PATTERN
    timeline = get_meta_info(line)

    dispatcher(timeline)
  else
    msg = ":message #{line}"
    routes(msg)
  end
end

def dispatcher(timeline)
  timestamp, command, content = timeline

  case command
    when ":exit"
      puts "[global] See you later :)"

      # Todo LifeCycle BeforeExit
      exit
    when ":message"
      puts "message:",content, timestamp
    when ":connect"
      puts "connect",content
    else
      puts "[error]: no command"
  end
end