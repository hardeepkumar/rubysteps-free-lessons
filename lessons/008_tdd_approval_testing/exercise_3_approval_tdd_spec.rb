require 'approvals/rspec'

class Receipt
  def self.print_v1(name, product, price)
    # fake it til you make it!
    "Pat paid $10 for RubySteps."
  end


  def self.print_v2(name, product, price)
    # replace the strings
    "#{name} paid $#{price} for #{product}."
  end

  def self.print_v3(name, product, price)
    # change the structure
    "Thank you, #{name} for your $#{price} purchase of #{product}."
  end
end

describe Receipt do
  it "prints a receipt (v1)" do
    verify { Receipt.print_v1("Pat", "RubySteps", "10") }
  end

  it "prints a receipt (v2)" do
    verify { Receipt.print_v2("Pat", "RubySteps", "10") }
  end

  it "prints a receipt (v3)" do
    verify { Receipt.print_v3("Pat", "RubySteps", "10") }
  end
end
