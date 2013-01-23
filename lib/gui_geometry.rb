require "gui_geometry/version"

%w{
  tools
  point
  rectangle
  version
}.each do |file|
  require File.join(File.dirname(__FILE__),"gui_geometry",file)
end

module GuiGeometry
  # Your code goes here...
end
