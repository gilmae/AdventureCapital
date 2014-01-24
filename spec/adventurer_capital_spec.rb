require File.dirname(__FILE__) + '/spec_helper'

describe AdventureCapital do
	it "should have a VERSION" do
		AdventureCapital.const_defined?('VERSION').should be_true
		AdventureCapital::VERSION.should == "0.0.1"
	end
end