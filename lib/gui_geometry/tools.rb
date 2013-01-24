module GuiGeometry
module Tools
  def min(a,b) a < b ? a : b; end
  def max(a,b) a > b ? a : b; end
  def minmax(a,b)
    if a <= b
      return a, b
    else
      return b, a
    end
  end
  def bound(a,bounded,c) max(a,min(bounded,c)); end

  def point(*args); GuiGeometry::Point.new *args end
  def rect(*args); GuiGeometry::Rectangle.new *args end
end
end
