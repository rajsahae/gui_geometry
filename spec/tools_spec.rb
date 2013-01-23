require 'spec_helper'

module GuiGeometry
describe "Tools" do
  include Tools

  it "min" do
    min(4,5).should == 4
  end
end
end
