module GuiGeo
class Point < Struct.new(:x, :y)
  include Tools

  def initialize(*args)
    self.x = self.y = 0
    super if args.length!=0
  end

  def min(b); point(Tools::min(x, b.x), Tools::min(y, b.y)); end
  def max(b); point(Tools::max(x, b.x), Tools::max(y, b.y)); end
  def bound(a, b); point(Tools::bound(a.x, x, b.x), Tools::bound(a.y, y, b.y)); end

  def clone_value(v)
    case v
    when Fixnum, Bignum, Float then v
    else v.clone
    end
  end

  def clone; point(clone_value(x), clone_value(y)); end

  def inspect; "point(#{x},#{y})" end
  def to_s; "(#{x},#{y})" end

  def >=(b) x>=b.x && y>=b.y end
  def <=(b) x<=b.x && y<=b.y end
  def >(b) x>b.x && y>b.y end
  def <(b) x<b.x && y<b.y end

  def +(b) b.kind_of?(Point) ? point(x+b.x, y+b.y) : point(x+b, y+b) end
  def -(b) b.kind_of?(Point) ? point(x-b.x, y-b.y) : point(x-b, y-b) end
  def *(b) b.kind_of?(Point) ? point(x*b.x, y*b.y) : point(x*b, y*b) end
  def /(b) b.kind_of?(Point) ? point(x/b.x, y/b.y) : point(x/b, y/b) end
end
end
