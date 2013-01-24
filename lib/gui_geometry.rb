
%w{
  tools
  point
  rectangle
  version
}.each do |file|
  require File.join(File.dirname(__FILE__),"gui_geometry",file)
end

module GuiGeometry
  def point(*args); GuiGeometry::Point.new *args end
  def rect(*args); GuiGeometry::Rectangle.new *args end
end
