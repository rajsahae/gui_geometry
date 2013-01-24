module GuiGeometry
module Tools
  include ::GuiGeometry
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
end
end
