module GuiGeometry
module Tools
  def min(a,b) a < b ? a : b; end
  def max(a,b) a > b ? a : b; end
  def bound(a,bounded,c) bounded < a ? a : (bounded > c) ? c : bounded; end

  def point(*args); GuiGeometry::Point.new *args end
  def rect(*args); GuiGeometry::Rectangle.new *args end
end
end
