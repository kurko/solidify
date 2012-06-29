require "solidify/parser/file"

describe Solidify::Parser::File do
  subject { described_class }

  before do
    @code = []
    File.open("spec/fixtures/class.rb").lines { |l| @code << l.gsub(/\n/, "") }
  end

  describe "#parse_methods_names" do
    it "returns an array with method names" do
      subject.new(@code).parse_methods_names.should && [
        :good_method, :many_responsibilities, :builder_method, :big_method
      ]
    end
  end

  describe "#method_code" do
    it "returns a Method instance" do
      method = double
      method.stub(:new).with([], :a_method) { method }
      method.should_receive(:code)
      subject.new([]).method_code(:a_method, method)
    end
  end
end
