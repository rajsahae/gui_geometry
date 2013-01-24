require 'spec_helper'

module GuiGeo
describe "Tools" do
  include Tools

  it "min" do
    min(4,5).should == 4
    min(5,4).should == 4
  end

  it "max" do
    max(4,5).should == 5
    max(5,4).should == 5
  end

  it "bound" do
    bound(2,5,7).should == 5
    bound(2,1,7).should == 2
    bound(2,8,7).should == 7
    bound(2,8,1).should == 2
  end

  it "minmax" do
    minmax(4,5).should == [4,5]
    minmax(5,4).should == [4,5]
  end

  it "easy constructors" do
    point.class.should == Point
    rect.class.should == Rectangle
  end
end
end
