require 'approvals/rspec'

def output_methods(target, methods)
  methods.inject([]) do |results, m|
    results << %("#{target}".#{m} => #{target.send(m)})
  end
end

describe "Ruby standard library" do
  it "has a useful String class" do
    string = "fOo"
    verify { output_methods(string, [:downcase, :upcase, :size, :empty?]) }
  end

  it "has a useful Hash class" do
    hash = { foo: 'bar' }
    verify { output_methods(hash, [:keys, :values, :size]) }
  end

  it "has a useful Array class" do
    array = [1, 2, 4, 3, 'chicken']
    verify { output_methods(array, [:first, :last, :size]) }
  end
end
