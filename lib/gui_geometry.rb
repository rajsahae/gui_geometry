
%w{
  tools
  point
  rectangle
  version
}.each do |file|
  require File.join(File.dirname(__FILE__),"gui_geometry",file)
end

module GuiGeo
  def point(*args); GuiGeo::Point.new *args end
  def rect(*args); GuiGeo::Rectangle.new *args end
end
