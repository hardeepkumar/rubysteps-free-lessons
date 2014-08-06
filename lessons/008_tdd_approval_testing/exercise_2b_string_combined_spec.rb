require 'approvals/rspec'

describe "string (combined)" do
  let(:string) { "fOo" }

  def string_methods
    [:downcase, :upcase, :size, :empty?].inject([]) do |results, m|
      results << %("#{string}".#{m} => #{string.send(m)})
    end
  end

  it "has many useful methods" do
    verify { string_methods }
  end

  xit "try it and see!" do
    verify { string_methods }
  end
end
