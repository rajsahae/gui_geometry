module GuiGeo
module Tools
  include ::GuiGeo
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

  def clone_value(v)
    case v
    when Fixnum, Bignum, Float then v
    else v.clone
    end
  end

  class << self
    include GuiGeo::Tools
  end
end
end
