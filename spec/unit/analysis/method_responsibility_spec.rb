require "solidify/analysis/method_responsibility"

describe Solidify::Analysis::MethodResponsibility do
  subject { described_class }

  before do
  end

  describe "#too_many_lines?" do
    it "should return false if less then 6" do
      subject.new([1, 2, 3, 4, 5]).too_many_lines?.should be_false
    end

    it "should return true if 6 or more lines" do
      subject.new([1, 2, 3, 4, 5, 6]).too_many_lines?.should be_true
    end
  end
end

