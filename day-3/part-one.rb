#!/usr/bin/ruby -F, -lan

BEGIN {
  def line_points(start, move)
    x, y = start
    dir, len = move
    len = len.to_i

    case dir
    when 'U'
      (y..(y + len)).map { |j| [x, j] }
    when 'D'
      y.downto(y - len).map { |j| [x, j] }
    when 'R'
      (x..(x + len)).map { |i| [i, y] }
    when 'L'
      x.downto(x - len).map { |i| [i, y] }
    end
  end

  points = []
}

last = [0, 0]
points.concat $F.flat_map{ |wire| *line, last = line_points(last, wire.partition(/\d+/).shift(2)); line }

END {
  point_hash = Hash.new(0)
  points.each { |point| point_hash[point] += 1 }
  point_hash.delete([0,0])
  point_hash.keep_if { |k,v| v > 1 }
  p point_hash.keys.map { |cross| cross[0].abs + cross[1].abs }.min
}
