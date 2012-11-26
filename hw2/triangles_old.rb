# Inspiration
# - [1] http://alienryderflex.com/polygon_area/
# - [2] http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=geometry2
# - [3] http://xboxforums.create.msdn.com/forums/p/40478/236744.aspx

class Triangles
	def initialize(input = STDIN)
		@data = []
    @vertices = []
		# Nacitanie dat
    while ! input.eof?
			@data += input.gets.split.collect! do |i|
        if i !~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
          puts "Spatny vstup." 
          return
        end
        i.to_f
			end
		end
    if @data.length != 12
      puts "Spatny vstup."
      return
    end
    @vertices << @data[0,2]
    @vertices << @data[2,2]
    @vertices << @data[4,2]
    @vertices << @data[6,2]
    @vertices << @data[8,2]
    @vertices << @data[10,2]
		# puts "# Read numbers: #{@vertices}" if $D
    @triangle1 = [@vertices[0], @vertices[1], @vertices[2]]
    @triangle2 = [@vertices[3], @vertices[4], @vertices[5]]
    puts "# Triangle 1: #{@triangle1}" if $D
    puts "# Triangle 2: #{@triangle2}" if $D
    if ! check_triangle(@triangle1) || ! check_triangle(@triangle2)
      puts "Spatny vstup."
      return
    end
    # Najdenie intersections
    for i in 0..2
      for j in 0..2
        line1 = [@triangle1[i],@triangle1[(i+1)%3]]
        line2 = [@triangle2[j],@triangle2[(j+1)%3]]
        intersect = detect_intersection line1, line2
        puts "# #{line1} and #{line2} have intersection #{intersect}" if $D && ! intersect.nil?
        @vertices << intersect if ! intersect.nil?
      end
    end
    if(@vertices.length == 6)
      puts "Trojuhelniky se nedotykaji."
      return
    end
    puts "# Vertices (#{@vertices.length}): #{@vertices}" if $D
    @center = get_center @vertices
    puts "# Center: #{@center}" if $D
    @vertices = sort_clockwise @vertices
    @vertices.reverse!
    puts "# Sorted vertices (#{@vertices.length}): #{@vertices}" if $D
    area = polygon_area(@vertices)
    puts "# Area: #{area}" if $D
    area_fmt = sprintf("%.4f", area.round(4))
    puts "Vysledny obsah: #{area_fmt}"
	end
  # Kontrola trojuholnikovej nerovnosti
  def check_triangle(tr)
    if  distance(tr[0], tr[1]) + distance(tr[1], tr[2]) < distance(tr[2], tr[0]) ||
        distance(tr[1], tr[2]) + distance(tr[2], tr[0]) < distance(tr[0], tr[1]) ||
        distance(tr[2], tr[0]) + distance(tr[0], tr[1]) < distance(tr[1], tr[2]) 
      return false
    end
    return true
  end
  # Vzdialenost medzi 2 bodmi
  def distance(point1, point2)
    a = point1[0] - point2[0]
    b = point1[1] - point2[1]
    Math.sqrt(a**2 + b**2)
  end
  # Detekcia pretnutia
  # Tak ako nas to ucili na strednej,
  #   alebo na stranke [2] :D
  def detect_intersection(line1, line2)
    # - Prevedieme na smernicovy tvar ax + by = c
    #p "Usecky: #{[line1, line2]}" if $D
    a1 =    line1[1][1] -    line1[0][1]
    b1 =    line1[0][0] -    line1[1][0]
    c1 = a1*line1[0][0] + b1*line1[0][1]
    a2 =    line2[1][1] -    line2[0][1]
    b2 =    line2[0][0] -    line2[1][0]
    c2 = a2*line2[0][0] + b2*line2[0][1]
    #p "Analyticky tvar: #{[[a1,b1,c1],[a2,b2,c2]]}"
    # - Riesime 2 rovnice o 2 neznamych
    det = a1*b2 - a2*b1
    # nulovy determinant == usecky rovnobezne
    if det == 0
      nil
    else
      # Este nam ostava kontrola, ci bod lezi na useckach
      intersect = [(b2*c1 - b1*c2)/det, (a1*c2 - a2*c1)/det]
      # Medzne hodnoty line1, line2
      line1_left   = [line1[0][0], line1[1][0]].min
      line1_right  = [line1[0][0], line1[1][0]].max
      line1_bottom = [line1[0][1], line1[1][1]].min
      line1_top    = [line1[0][1], line1[1][1]].max
      line2_left   = [line2[0][0], line2[1][0]].min
      line2_right  = [line2[0][0], line2[1][0]].max
      line2_bottom = [line2[0][1], line2[1][1]].min
      line2_top    = [line2[0][1], line2[1][1]].max
      # Skontrolujeme medzne hodnoty intersekcie
      if  intersect[0] < line1_left   || intersect[0] < line2_left   ||
          intersect[0] > line1_right  || intersect[0] > line2_right  ||
          intersect[1] < line1_bottom || intersect[1] < line2_bottom ||
          intersect[1] > line1_top    || intersect[1] > line2_top
        return nil
      end
      return intersect
    end
  end
  def get_center(vertices)
    sum = [0,0]
    vertices.each do |v|
      sum[0] += v[0]
      sum[1] += v[1]
    end
    [sum[0]/vertices.length,sum[1]/vertices.length]
  end
  # Inspirovane [3], ale tu je to nespravne - opravene vlastnou hlavou
  def sort_clockwise(vertices)
    center = get_center vertices
    vertices.sort do |a,b|
      angle1 = Math.atan2(a[1]-center[1],a[0]-center[0])
      angle2 = Math.atan2(b[1]-center[1],b[0]-center[0])
      angle1 <=> angle2
    end
  end
  def polygon_area(vertices)
    area = 0
    i = 0
    j = vertices.length-1
    for i in 0..vertices.length-1
      area += (vertices[j][0]+vertices[i][0])*(vertices[j][1]-vertices[i][1])
      j = i
    end
    return area*0.5
  end
end













