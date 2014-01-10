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

  describe "#search_option" do
    subject { search_class }

    describe "options" do

      before do
        subject.send(:define_method, :jellies) do
          %w(strawberry raspberry lime lemon pork)
        end
      end

      it "evaluates in context of the instance of responds to #to_proc?" do
        subject.search_option :jelly, options: :jellies
        subject.new({}).options_for(:jelly).must_equal %w(strawberry raspberry lime lemon pork)
      end
    end
  end
end
