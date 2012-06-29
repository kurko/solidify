require "solidify/parser/method"

describe Solidify::Parser::Method do
  subject { described_class }

  before do
    @code = []
    File.open("spec/fixtures/class.rb").lines { |l| @code << l.gsub(/\n/, "") }
  end

  describe "#code" do
    it "returns good_method() method code" do
      lines = subject.new(@code, :good_method).code
      lines[0].should == "a_object = SomeClass.new"
      lines[1].should == "a_object.do_something"
      lines[2].should be_nil
    end

    it "returns code when end is confusing" do
      meth = subject.new(@code, :confusing_end)
      lines = meth.code
      lines[0].should == "variable = \"end\""
      lines[1].should == "variable <<-eos"
      lines[2].should == "end"
      lines[3].should == "eos"
      lines[4].should be_nil
    end
  end

  describe "#def?" do
    it "returns true when method name matches" do
      subject.new(@code, :meth).def?(" def meth(args)\n").should be_true
    end

    it "returns false when method name doesn't matches" do
      subject.new(@code, :meth).def?(" def foo(args)\n").should be_false
    end
  end

  describe "#end?" do
    let(:meth) { subject.new(@code, :meth) }

    it "returns true when an end is found" do
      meth.end?(" end\n").should be_true
    end

    it "returns false when an end is found but inside a string" do
      meth.stub(:inside_string?) { true }
      meth.end?(" end\n").should be_false
    end

    it "returns false when an end is found but inside a string" do
      meth.end?(" ending").should be_false
    end
  end

  describe "#inside_string" do
    it "returns true when inside string" do
      meth = subject.new(@code, :meth)
      meth.inside_string?(" <<eos").should be_true
      meth.inside_string?("variable <<-eos").should be_true
      meth.inside_string?.should be_true
      meth.inside_string?("eos do").should be_true
      meth.inside_string?("eos").should be_false
      meth.inside_string?.should be_false
    end
  end
end
