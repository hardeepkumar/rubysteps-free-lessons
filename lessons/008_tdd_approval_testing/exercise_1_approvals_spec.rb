require 'approvals/rspec'

class RubySteps
  def self.lesson_007
    "this is lesson 007"
  end
end

describe RubySteps do
  it 'has a cool lesson 007' do
    verify { RubySteps.lesson_007 }
  end
end
