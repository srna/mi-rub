Point = Struct.new(:x, :y)

class Triangles
	def initialize(input = STDIN)
		data = []
		# Nacitanie dat
    while ! input.eof?
			data += input.gets.split.collect! do |i|
        if i !~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
          puts "Spatny vstup." 
          return
        end
        i.to_f
			end
		end
    if data.length != 12
      puts "Spatny vstup."
      return
    end
    points = []
    data.each_slice(2) do |d|
      points << Point.new(*d)
    end
    puts "# Data:    #{data}" if $D
    puts "# Points:  #{points}" if $D
    @subj = ccw points[0,3]
    @clip = ccw points[3,3]
    puts "# Subject: #{@subj}" if $D
    puts "# Clip:    #{@clip}" if $D

    @merg = sutherland_hodgman
    puts "# Merge:   #{@merg}" if $D

    if @merg.empty? && (@subj & @clip).empty? && ! check_edge_overlap(@subj, @clip)
      puts "Trojuhelniky se nedotykaji."
      return
    end

    tri1_area = polygon_area @subj.reverse
    tri2_area = polygon_area @clip.reverse
    merg_area = polygon_area @merg.reverse

    puts "# T1 Area: #{tri1_area}" if $D
    puts "# T2 Area: #{tri2_area}" if $D
    puts "# MG Area: #{merg_area}" if $D

    area = tri1_area+tri2_area-merg_area
    area_fmt = sprintf("%.04f", area.round(4))

    puts "Vysledny obsah: #{area_fmt}"
	end

  # Sutherland-Hodgman polygon clipping
  # Needs ccw, outputs ccw
  def sutherland_hodgman
    out = @subj
    cp1 = @clip.last

    @clip.each do |cv|
      cp2 = cv
      inp = out
      out = []
      s = inp.last
      inp.each do |sv|
        e = sv
        if inside(e, cp1, cp2)
          if ! inside(s, cp1, cp2)
            out << intersection(e,s,cp1,cp2)
          end
          out << e
        elsif inside(s, cp1, cp2)
          out << intersection(e,s,cp1,cp2)
        end
        s = e
      end
      cp1 = cp2
      puts "# Iter:    #{out}" if $D
    end
    return out
  end
  # Test if point p inside half plane cp1,cp2
  def inside(p,cp1,cp2)
    return (cp2.x-cp1.x)*(p.y-cp1.y) > (cp2.y-cp1.y)*(p.x-cp1.x)
  end
  # Intersection
  def intersection(e,s,cp1,cp2)
    dc = Point.new(cp1.x - cp2.x, cp1.y - cp2.y)
    dp = Point.new(s.x - e.x, s.y - e.y)
    n1 = cp1.x*cp2.y - cp1.y*cp2.x
    n2 = s.x*e.y - s.y*e.x
    n3 = 1.0 / (dc.x*dp.y-dc.y*dp.x)
    inter = Point.new((n1*dp.x - n2*dc.x)*n3, (n1*dp.y - n2*dc.y)*n3)
    puts "# Found intersection #{inter}" if $D
    return inter
  end
  # Area of polygon inspired by [1]
  # Needs cw
  def polygon_area(polygon)
    area = 0
    i = 0
    j = polygon.length-1
    for i in 0..polygon.length-1
      area += (polygon[j].x+polygon[i].x)*(polygon[j].y-polygon[i].y)
      j = i
    end
    return area*0.5
  end
  # Stred bodov
  def get_center(vertices)
    sum = [0,0]
    vertices.each do |v|
      sum[0] += v[0]
      sum[1] += v[1]
    end
    [sum[0]/vertices.length,sum[1]/vertices.length]
  end
  # Counter-Clockwise sort
  # Inspirovane [2], ale tu je to nespravne - opravene vlastnou hlavou
  def ccw(vertices)
    center = get_center vertices
    vertices.sort do |a,b|
      angle1 = Math.atan2(a[1]-center[1],a[0]-center[0])
      angle2 = Math.atan2(b[1]-center[1],b[0]-center[0])
      angle1 <=> angle2
    end
  end
  # Prevod na smernicovy tvar (vlastna hlava)
  # y = kx + q -> vystup [k,q]
  def line_equation(point1, point2)
    k = (point2.y - point1.y) / (point2.x - point1.x)
    q = point1.y - k*point1.x
    return [k,q]
  end
  # Kontrola prekryvu useciek
  def check_overlap(line1, line2)
    e1 = line_equation(line1[0], line1[1])
    e2 = line_equation(line2[0], line2[1])
    k1, q1 = e1[0], e1[1]
    k2, q2 = e2[0], e2[1]
    return false if k1 != k2 || q1 != q2
    # Medzne hodnoty line1, line2
    line1_left   = [line1[0].x, line1[1].x].min
    line1_right  = [line1[0].x, line1[1].x].max
    line1_bottom = [line1[0].y, line1[1].y].min
    line1_top    = [line1[0].y, line1[1].y].max
    line2_left   = [line2[0].x, line2[1].x].min
    line2_right  = [line2[0].x, line2[1].x].max
    line2_bottom = [line2[0].y, line2[1].y].min
    line2_top    = [line2[0].y, line2[1].y].max
    # Kontrola X-ovy smer
    return false if line1_left > line2_right
    return false if line2_left > line1_right
    # Kontrola Y-ovy smer
    return false if line1_bottom > line2_top
    return false if line2_bottom > line2_top
    return true
  end
  # Kontrola trojuholnikov na edge overlap
  def check_edge_overlap(triangle1, triangle2)
    for i in 0..2
      for j in 0..2
        return true if check_overlap([triangle1[i],triangle1[(i+1)%3]],[triangle2[j],triangle2[(j+1)%3]])
      end
    end
    return false
  end
end

# Inspiration
# - [1] http://alienryderflex.com/polygon_area/
# - [2] http://xboxforums.create.msdn.com/forums/p/40478/236744.aspx
# Abbreviations
# - [cw] clockwise
# - [ccw] counter-clockwise










