require_relative 'spec_helper'
describe "tests" do
  it "should runs some tests" do
    true.must_equal false
  end

  it "Should have access to the other files" do
    TEST_CONSTANT.must_equal 77
  end
end
