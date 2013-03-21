require 'spec_helper'

module GuiGeo
describe "Rectangle" do
  include ::GuiGeo

  it "defaults" do
    rect.should == rect(0,0,0,0)
    rect.should == rect(point,point)
  end

  it "invalid init" do
    expect { rect(1,2,3,4,5) }.to raise_error
  end

  it "clone" do
    r1 = rect(1,2,3,4)
    r2 = r1.clone
    r1.should == r2
    r1.object_id.should_not == r2.object_id
    r1.loc.object_id.should_not == r2.loc.object_id
    r1.size.object_id.should_not == r2.size.object_id
  end

  it "init with one point" do
    rect(point(1,2)).should == rect(0,0,1,2)
  end

  it "inspect" do
    rect.inspect.class.should == String
  end

  it "contains?" do
    rect(0,0,10,10).contains?(rect(2,2,5,5)).should == true
    rect(0,0,10,10).contains?(rect(8,2,5,5)).should == false
  end

  it ".overlap?" do
    # solidly overlapping
    rect(0,0,10,10).overlaps?(rect(0,0,10,10)).should == true
    rect(0,0,10,10).overlaps?(rect(0,5,10,10)).should == true
    rect(0,0,10,10).overlaps?(rect(5,0,10,10)).should == true

    # just below, just to the right, just above, just to the left
    rect(0,0,10,10).overlaps?(rect(10,0,10,10)).should == false
    rect(0,0,10,10).overlaps?(rect(0,10,10,10)).should == false
    rect(10,0,10,10).overlaps?(rect(0,0,10,10)).should == false
    rect(0,10,10,10).overlaps?(rect(0,0,10,10)).should == false

    # below, right, above, left
    rect(0,0,10,10).overlaps?(rect(11,0,10,10)).should == false
    rect(0,0,10,10).overlaps?(rect(0,11,10,10)).should == false
    rect(11,0,10,10).overlaps?(rect(0,0,10,10)).should == false
    rect(0,11,10,10).overlaps?(rect(0,0,10,10)).should == false

    # just overlapping below, right, above, left
    rect(0,0,10,10).overlaps?(rect(9,0,10,10)).should == true
    rect(0,0,10,10).overlaps?(rect(0,9,10,10)).should == true
    rect(9,0,10,10).overlaps?(rect(0,0,10,10)).should == true
    rect(0,9,10,10).overlaps?(rect(0,0,10,10)).should == true
  end

  it ".union" do
    (rect(0,0,10,10)   & rect(0,5,10,10)).should == rect(0,0,10,15)
    (rect(0,0,10,10)   & rect(5,0,10,10)).should == rect(0,0,15,10)
    (rect(20,20,10,10) & rect(0,0,10,10)).should == rect(0,0,30,30)
  end

  it ".intersection" do
    (rect(0,0,10,10)   | rect(0,0,10,10)).should == rect(0,0,10,10)
    (rect(0,0,10,10)   | rect(0,5,10,10)).should == rect(0,5,10,5)
    (rect(0,0,10,10)   | rect(5,0,10,10)).should == rect(5,0,5,10)
    (rect(0,0,10,10)   | rect(10,0,10,10)).should == rect(0,0,0,0)
    (rect(0,0,10,10)   | rect(-5,-5,10,10)).should == rect(0,0,5,5)
  end

  it "default intersection and union" do
    (rect(0,0,10,10) | nil).should == rect(0,0,10,10)
    (rect(0,0,10,10) & nil).should == rect(0,0,10,10)
  end

  it ".present?" do
    rect(0,0,1,1).present?.should == true
    rect(0,0,1,0).present?.should == false
    rect(0,0,0,1).present?.should == false
    rect(0,0,0,0).present?.should == false
  end

  it ".blank?" do
    rect(0,0,1,1).blank?.should == false
    rect(0,0,1,0).blank?.should == true
    rect(0,0,0,1).blank?.should == true
    rect(0,0,0,0).blank?.should == true
  end

  it ".bound(point)" do
    r = rect(5, 10, 15, 20)
    r.bound(point(5,10)).should == point(5,10)
    r.bound(point(20,30)).should == point(20,30)
    r.bound(point(5,31)).should == point(5,30)
    r.bound(point(21,10)).should == point(20,10)
    r.bound(point(5,10)).should == point(5,10)
    r.bound(point(5, 9)).should == point(5,10)
    r.bound(point(4,10)).should == point(5,10)
  end

  it ".bound(smaller_rect)" do
    r1 = rect(5, 10, 15, 20)
    r1.bound(rect(5,0,5,5)).should == rect(5,10,5,5)
    r1.bound(rect(0,10,5,5)).should == rect(5,10,5,5)
    r1.bound(rect(0,30,5,5)).should == rect(5,25,5,5)
    r1.bound(rect(30,0,5,5)).should == rect(15,10,5,5)
    r1.bound(rect(0,0,20,5)).should == rect(5,10,15,5)
  end

  it ".overlaps? point" do
    r1 = rect(5, 10, 15, 20)
    r1.overlaps?(point(10,10)).should == true
    r1.overlaps?(point(20,10)).should == false
    r1.overlaps?(point(10,30)).should == false
    r1.overlaps?(point(5,9)).should == false
    r1.overlaps?(point(4,10)).should == false
  end

  it ".contains? point" do
    r1 = rect(5, 10, 15, 20)
    r1.contains?(point(10,10)).should == true
    r1.contains?(point(20,10)).should == false
    r1.contains?(point(10,30)).should == false
    r1.contains?(point(5,9)).should == false
    r1.contains?(point(4,10)).should == false
  end

  it ".contains? and .overlaps? with nil" do
    r1 = rect(5, 10, 15, 20)
    r1.overlaps?(nil).should == false
    r1.contains?(nil).should == false
  end

  it ".area" do
    rect(5, 10, 15, 20).area.should == 300
  end

  it ".y_range and .x_range" do
    rect(5, 10, 15, 20).x_range.should == (5...20)
    rect(5, 10, 15, 20).y_range.should == (10...30)
    rect(0,0,0,0).x_range.should == (0...0)
    rect(0,0,0,0).y_range.should == (0...0)
  end
end
end
