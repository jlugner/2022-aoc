def distance(x, other_x, y, other_y) = (x - other_x).abs + (y - other_y).abs

Sensor = Struct.new(:x, :y, :close_x, :close_y, :beacon_distance) do
  def initialize(x, y, close_x, close_y)
    super(x, y, close_x, close_y, distance(x, close_x, y, close_y))
  end
end

sensors = DATA.readlines.map { Sensor.new(*_1.scan(/-?\d+/).map(&:to_i)) }

def find_available_on_row(sensors, low_x, high_x, y)
  applicable_sensors = sensors.filter { ((_1.y - _1.beacon_distance)..(_1.y + _1.beacon_distance)).cover?(y) }
  beacon_xs = applicable_sensors.filter_map { _1.close_y == y && _1.close_x }
  blocked_xs = applicable_sensors.each_with_object([]) do |sensor, arr|
    low_x.upto(high_x) do |x|
      coordinate_distance = distance(sensor.x, x, sensor.y, y)
      arr << x if sensor.beacon_distance >= coordinate_distance
    end
  end

  low_x.upto(high_x).to_a - blocked_xs - beacon_xs
end

def find_single_available(sensors, low_bound, high_bound)
  sensors.each do |sensor|
    low_y = [low_bound, sensor.y - sensor.beacon_distance - 1].max
    high_y = [high_bound, sensor.y + sensor.beacon_distance + 1].min
    low_x = [low_bound, sensor.x - sensor.beacon_distance - 1].max
    high_x = [high_bound, sensor.x + sensor.beacon_distance + 1].min
    low_y.upto(high_y).each do |y|
      width = (sensor.beacon_distance + 1) - (y - sensor.y).abs
      [sensor.x - width, sensor.x + width].each do |x|
        next if x < low_x || x > high_x
        break if sensors.any? do |other_sensor|
          next if sensor == other_sensor

          coordinate_distance = distance(other_sensor.x, x, other_sensor.y, y)
          coordinate_distance <= other_sensor.beacon_distance
        end

        return [x, y]
      end
    end
  end
end

# A
lower_x_bound = sensors.map { [_1.x, _1.close_x, _1.x - _1.beacon_distance].min }.min
upper_x_bound = sensors.map { [_1.x, _1.close_x, _1.x + _1.beacon_distance].max }.max
available_slots = find_available_on_row(sensors, lower_x_bound, upper_x_bound, 200_000_0)
claimed = (upper_x_bound - lower_x_bound) - available_slots.count
pp "A: #{claimed}"

# B
bound = 400_000_0
x, y = find_single_available(sensors, 0, bound)

p "B: #{x * bound + y}"

__END__
Sensor at x=3291456, y=3143280: closest beacon is at x=3008934, y=2768339
Sensor at x=3807352, y=3409566: closest beacon is at x=3730410, y=3774311
Sensor at x=1953670, y=1674873: closest beacon is at x=2528182, y=2000000
Sensor at x=2820269, y=2810878: closest beacon is at x=2796608, y=2942369
Sensor at x=3773264, y=3992829: closest beacon is at x=3730410, y=3774311
Sensor at x=2913793, y=2629579: closest beacon is at x=3008934, y=2768339
Sensor at x=1224826, y=2484735: closest beacon is at x=2528182, y=2000000
Sensor at x=1866102, y=3047750: closest beacon is at x=1809319, y=3712572
Sensor at x=3123635, y=118421: closest beacon is at x=1453587, y=-207584
Sensor at x=2530789, y=2254773: closest beacon is at x=2528182, y=2000000
Sensor at x=230755, y=3415342: closest beacon is at x=1809319, y=3712572
Sensor at x=846048, y=51145: closest beacon is at x=1453587, y=-207584
Sensor at x=3505756, y=3999126: closest beacon is at x=3730410, y=3774311
Sensor at x=2506301, y=3745758: closest beacon is at x=1809319, y=3712572
Sensor at x=1389843, y=957209: closest beacon is at x=1453587, y=-207584
Sensor at x=3226352, y=3670258: closest beacon is at x=3730410, y=3774311
Sensor at x=3902053, y=3680654: closest beacon is at x=3730410, y=3774311
Sensor at x=2573020, y=3217129: closest beacon is at x=2796608, y=2942369
Sensor at x=3976945, y=3871511: closest beacon is at x=3730410, y=3774311
Sensor at x=107050, y=209321: closest beacon is at x=1453587, y=-207584
Sensor at x=3931251, y=1787536: closest beacon is at x=2528182, y=2000000
Sensor at x=1637093, y=3976664: closest beacon is at x=1809319, y=3712572
Sensor at x=2881987, y=1923522: closest beacon is at x=2528182, y=2000000
Sensor at x=3059723, y=2540501: closest beacon is at x=3008934, y=2768339
