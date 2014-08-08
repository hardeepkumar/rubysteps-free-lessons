def print_something(stream, string)
  stream.puts string
end

class StarWrapper
  def initialize(stream)
    @stream = stream
  end

  def puts(string)
    print_header_line string
    @stream.print "* "
    @stream.print string
    @stream.puts " *"
    print_header_line string
  end

  def print_header_line(string)
    (string.size + 4).times { @stream.print "*" }
    @stream.puts
  end
end

wrapper = StarWrapper.new $stdout
print_something wrapper, "Hello RubySteps!"
