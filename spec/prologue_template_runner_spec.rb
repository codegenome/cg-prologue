require 'spec_helper'

describe Prologue::TemplateRunner do

  it "should raise an error if the on_invocation method isn't implemented" do
    eval <<-___
      class TestTemplate < ::Prologue::TemplateRunner; end
    ___
    lambda {
      begin
        TestTemplate.new.on_invocation
      rescue Exception => e
        raise e.inspect
      end
    }.should raise_error
  end

end

