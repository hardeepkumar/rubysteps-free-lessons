require 'approvals/rspec'

describe String do
  it "upcases strings" do
    verify { "foo".upcase }
  end

  it "downcases strings" do
    verify { "FOO".downcase }
  end

  it "counts a string's size" do
    verify { "foo".size }
  end

  xit "determines whether it's empty" do
    verify { "foo".empty? }
  end
end
