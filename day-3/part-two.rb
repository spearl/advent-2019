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

  point_sets = []
}

last = [0, 0]
point_sets.append $F.flat_map{ |wire| *line, last = line_points(last, wire.partition(/\d+/).shift(2)); line }

END {
  point_hash = Hash.new(0)
  point_sets.each { |point_set| point_set.uniq.each { |point| point_hash[point] += 1 } }
  point_hash.delete([0,0])
  point_hash.keep_if { |k,v| v > 1 }

  dist_hashes = []
  point_sets.each do |point_set|
    dist_hash = Hash.new(0)
    point_set.each_with_index do |point, i|
      if (point_hash.has_key?(point) && !dist_hash.has_key?(point))
        dist_hash[point] = i 
      end
    end
    dist_hashes.append dist_hash
  end
  p dist_hashes[0].merge(dist_hashes[1]) {|key, left, right| left + right }.values.min

  # Quadratic O(n^2)
  # p point_hash.keys.map { |cross| point_sets[0].index(cross) + point_sets[1].index(cross) }.min
}
