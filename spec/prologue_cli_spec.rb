require 'spec_helper'

describe Prologue::CLI do

  it "should raise an error if a bad template name is passed in" do
    lambda {
      instance = Prologue::CLI.new
      instance.new( "app" , "bogus" )
    }.should raise_error
  end

end

