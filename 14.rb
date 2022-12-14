GRID_BLOCKERS = ['#', '~'].freeze

def next_candidates(coordinate)
  [[coordinate.y + 1, coordinate.x], [coordinate.y + 1, coordinate.x - 1], [coordinate.y + 1, coordinate.x + 1]]
end

def can_move?(coordinate, grid)
  next_candidates(coordinate).any? { |y, x| grid[y] && !GRID_BLOCKERS.include?(grid[y][x]) }
end

Coordinate = Struct.new(:x, :y) do
  def initialize(x, y)
    super(Integer(x), Integer(y))
  end
end

rocks = DATA.readlines.map(&:chomp).map do |rock|
  rock.split(' -> ').map { |point| point.split(',').then { Coordinate.new(_1, _2) } }
end

def build_map(rocks, left, right, roof, floor)
  grid = []
  floor.upto(roof) do |y|
    row = []
    left.upto(right) do |x|
      row[x] = '.'
    end
    grid[y] = row
  end

  rocks.each do |rock_path|
    rock_path.each_cons(2) do |a, b|
      if a.x == b.x
        upper = [a.y, b.y].max
        lower = [a.y, b.y].min
        lower.upto(upper) do |y|
          grid[y][a.x] = '#'
        end
      else
        upper = [a.x, b.x].max
        lower = [a.x, b.x].min
        lower.upto(upper) do |x|
          grid[a.y][x] = '#'
        end
      end
    end
  end
  grid
end

def simulate_sand(grid, left, right, heigh_y, has_floor: false)
  sand = Coordinate.new(500, 0)
  while true
    sand = Coordinate.new(500, 0)
    while can_move?(sand, grid)
      next_candidates(sand).each do |y, x|
        next if GRID_BLOCKERS.include?(grid[y][x])

        grid[sand.y][sand.x] = '.'
        sand.y = y
        sand.x = x
        grid[sand.y][sand.x] = '~'
        break
      end

      next unless has_floor

      next_candidates(sand).each do |y, x|
        if y == heigh_y && grid[y][x].nil?
          grid.each { |row| row[x] = '.' }
          grid[y][x] = '#'
        end
      end
    end

    if has_floor
      break if sand.x == 500 && sand.y.zero?
    else
      break unless (left..right).cover?(sand.x) && heigh_y > sand.y
    end
  end

  grid
end

# A
lower_x_bound = rocks.map { _1.min_by(&:x).x }.min
upper_x_bound = rocks.map { _1.max_by(&:x).x }.max
lower_y_bound = 0 # Sand spawn
upper_y_bound = rocks.map { _1.max_by(&:y).y }.max

grid = build_map(rocks, lower_x_bound, upper_x_bound, upper_y_bound, lower_y_bound)

sand_count = simulate_sand(grid, lower_x_bound, upper_x_bound, upper_y_bound).flatten.join.count('~') - 1
pp "A: #{sand_count}"

# B
rocks << [Coordinate.new(lower_x_bound, upper_y_bound + 2), Coordinate.new(upper_x_bound, upper_y_bound + 2)]
upper_y_bound = rocks.map { _1.max_by(&:y).y }.max

grid = build_map(rocks, lower_x_bound, upper_x_bound, upper_y_bound, lower_y_bound)
grid = simulate_sand(grid, lower_x_bound, upper_x_bound, upper_y_bound, has_floor: true)
sand_count = grid.flatten.join.count('~') + 1 # Last sand not rendered

pp "B: #{sand_count}"

__END__
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
