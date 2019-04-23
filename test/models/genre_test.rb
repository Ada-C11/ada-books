require "test_helper"

describe Genre do
  let(:genre) { genres(:fantasy) }

  it "must be valid" do
    value(genre).must_be :valid?
  end
end
