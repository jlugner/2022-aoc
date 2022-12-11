instructions = DATA.readlines
x = 1
cycle = 0
signal_strengths = []
signal_intervals = (-20..(instructions.count * 2)).step(40).to_a
pixels = []
instructions.each do |instruction|
  cycle += 1

  signal_strengths << x * cycle if signal_intervals.include?(cycle)
  pixels << ([x - 1, x, x + 1].any? { (cycle % 40) - 1 == _1 } ? '#' : '.')
  next if instruction.start_with?('noop')

  cycle += 1

  signal_strengths << x * cycle if signal_intervals.include?(cycle)
  pixels << ([x - 1, x, x + 1].any? { (cycle % 40) - 1 == _1 } ? '#' : '.')

  _k, inc = instruction.split(' ')
  x += Integer(inc)
end

pp "A: #{signal_strengths.sum}"

# B
pixels.each_slice(40) do |chunk|
  p chunk.join
end


__END__
addx 2
addx 3
addx 1
noop
addx 4
noop
noop
noop
addx 5
noop
addx 1
addx 4
addx -2
addx 3
addx 5
addx -1
addx 5
addx 3
addx -2
addx 4
noop
noop
noop
addx -27
addx -5
addx 2
addx -7
addx 3
addx 7
addx 5
addx 2
addx 5
noop
noop
addx -2
noop
addx 3
addx 2
addx 5
addx 2
addx 3
noop
addx 2
addx -29
addx 30
addx -26
addx -10
noop
addx 5
noop
addx 18
addx -13
noop
noop
addx 5
noop
noop
addx 5
noop
noop
noop
addx 1
addx 2
addx 7
noop
noop
addx 3
noop
addx 2
addx 3
noop
addx -37
noop
addx 16
addx -12
addx 29
addx -16
addx -10
addx 5
addx 2
addx -11
addx 11
addx 3
addx 5
addx 2
addx 2
addx -1
addx 2
addx 5
addx 2
noop
noop
noop
addx -37
noop
addx 17
addx -10
addx -2
noop
addx 7
addx 3
noop
addx 2
addx -10
addx 22
addx -9
addx 5
addx 2
addx -5
addx 6
addx 2
addx 5
addx 2
addx -28
addx -7
noop
noop
addx 1
addx 4
addx 17
addx -12
noop
noop
noop
noop
addx 5
addx 6
noop
addx -1
addx -17
addx 18
noop
addx 5
noop
noop
noop
addx 5
addx 4
addx -2
noop
noop
noop
noop
noop
