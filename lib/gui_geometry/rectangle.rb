module GuiGeo
class Rectangle < Struct.new(:loc, :size)
  include Tools

  def initialize(*args)
    case args.length
    when 0 then super point, point
    when 1 then super point, args[0].clone
    when 2 then super args[0].clone, args[1].clone
    when 4 then super point(*args[0..1]), point(*args[2..3])
    else raise ArgumentError.new
    end
  end

  def +(b) b.kind_of?(Point) ? rect(loc+b, size) : rect(loc+b.loc, size+b.size) end
  def -(b) b.kind_of?(Point) ? rect(loc-b, size) : rect(loc-b.loc, size-b.size) end

  def present?
    w > 0 && h > 0
  end

  def blank?
    !present?
  end

  def clone
    rect loc.clone, size.clone
  end

  # val can be a Rectangle or Point
  # returns a Rectangle or Point that is within this Rectangle
  # For Rectangles, the size is only changed if it has to be
  def bound(val)
    case val
    when Rectangle then
      r = val.clone
      r.size = r.size.min(size)
      r.loc = r.loc.bound(loc, loc + size - val.size)
      r
    when Point then (val-loc).bound(point, size) + loc
    else raise ArgumentError.new("wrong type: (#{val.class}) - Rectangle or Point expected")
    end
  end

  def x; loc.x; end
  def y; loc.y; end
  def w; size.w; end
  def h; size.h; end
  alias :width :w
  alias :height :h

  def area; size.area; end

  def x_range; x .. (x + w - 1) end
  def y_range; y .. (y + h - 1) end

  def inspect
    "rect"+to_s
  end

  def to_s
    "(#{[loc.x,loc.y,size.x,size.y].join ','})"
  end

  def overlaps?(val)
    case val
    when nil then false
    when Point then
      contains?(val)
    when Rectangle then
      val.loc + val.size > loc &&
      loc + size > val.loc
    else raise ArgumentError.new("wrong type: (#{val.class}) - Rectangle or Point expected")
    end
  end

  def contains?(val)
    case val
    when nil then false
    when Point then
      val >= loc && val < (loc+size)
    when Rectangle then
      (self & val) == self
    else raise ArgumentError.new("wrong type: (#{val.class}) - Rectangle or Point expected")
    end
  end

  def tl; loc; end
  def br; loc + size; end
  def bl; point(x, y + h); end
  def tr; point(x + w, y); end


  def union(b)
    return clone unless b
    l = loc.min(b.loc)
    s = br.max(b.br) - l
    rect l, s
  end
  alias :& :union

  def intersection(b)
    return self unless b
    l = loc.max(b.loc)
    s = br.min(b.br) - l
    return rect unless s>point
    rect l, s
  end
  alias :| :intersection
end
end
