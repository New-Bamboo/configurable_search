require 'spec_helper'

describe ConfigurableSearch do

  let(:search_class) { Class.new { include ConfigurableSearch } }

  describe "#query" do
    subject { search_class.new({}) }

    it "should fail when the including class doesn't define the method" do
      proc {
        subject.query
      }.must_raise NotImplementedError
    end
  end
end
