def print_block(output, &block)
  block.call output
end

class Chicken
  def speak(output)
    output.puts "bugawk!"
  end

  def to_proc
    lambda {|output| speak output }
  end
end

print_block $stdout, &Chicken.new
