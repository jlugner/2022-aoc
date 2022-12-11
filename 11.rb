input = DATA.read.split("\n\n")

def grab_numbers(string) = string.scan(/\d+/).map(&:to_i)
def grab_number(string)  = grab_numbers(string).first

Monkey = Struct.new(:items, :operation, :test_case, :happy, :sad, :inspections) do
  def initialize(items, operation, test_case, happy, sad)
    super(items, operation, test_case, happy, sad, 0)
  end

  def perform_operation(item)
    self.inspections += 1
    eval(operation.gsub('old', item.to_s))
  end

  def receiving_monkey(item)
    (item % test_case).zero? ? happy : sad
  end
end

def start_state(input)
  input.each_with_object([]) do |monkey_input, monkeys|
    _index, items, operation, test_case, happy_case, sad_case = monkey_input.lines.map(&:chomp)
    monkeys << Monkey.new(
      grab_numbers(items),
      operation.split('=').last,
      grab_number(test_case),
      grab_number(happy_case),
      grab_number(sad_case)
    )
  end
end

def simulate_keep_away(monkeys:, rounds:, worry_reduce_factor:)
  max_worry = monkeys.map(&:test_case).inject(:*)
  rounds.times do
    monkeys.each do |monkey|
      until monkey.items.empty?
        item = monkey.perform_operation(monkey.items.pop).then { (_1 / worry_reduce_factor) % max_worry }
        monkeys[monkey.receiving_monkey(item)].items.unshift(item)
      end
    end
  end
  monkeys
end

short_game = simulate_keep_away(monkeys: start_state(input), rounds: 20, worry_reduce_factor: 3)
long_game = simulate_keep_away(monkeys: start_state(input), rounds: 100_00, worry_reduce_factor: 1)

pp short_game.map(&:inspections).sort.last(2).inject(:*)
pp long_game.map(&:inspections).sort.last(2).inject(:*)

__END__
Monkey 0:
  Starting items: 91, 54, 70, 61, 64, 64, 60, 85
  Operation: new = old * 13
  Test: divisible by 2
    If true: throw to monkey 5
    If false: throw to monkey 2

Monkey 1:
  Starting items: 82
  Operation: new = old + 7
  Test: divisible by 13
    If true: throw to monkey 4
    If false: throw to monkey 3

Monkey 2:
  Starting items: 84, 93, 70
  Operation: new = old + 2
  Test: divisible by 5
    If true: throw to monkey 5
    If false: throw to monkey 1

Monkey 3:
  Starting items: 78, 56, 85, 93
  Operation: new = old * 2
  Test: divisible by 3
    If true: throw to monkey 6
    If false: throw to monkey 7

Monkey 4:
  Starting items: 64, 57, 81, 95, 52, 71, 58
  Operation: new = old * old
  Test: divisible by 11
    If true: throw to monkey 7
    If false: throw to monkey 3

Monkey 5:
  Starting items: 58, 71, 96, 58, 68, 90
  Operation: new = old + 6
  Test: divisible by 17
    If true: throw to monkey 4
    If false: throw to monkey 1

Monkey 6:
  Starting items: 56, 99, 89, 97, 81
  Operation: new = old + 1
  Test: divisible by 7
    If true: throw to monkey 0
    If false: throw to monkey 2

Monkey 7:
  Starting items: 68, 72
  Operation: new = old + 8
  Test: divisible by 19
    If true: throw to monkey 6
    If false: throw to monkey 0
