defmodule Day3Test do
  use ExUnit.Case

  test "example part 1" do
    input = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    want = 4361
    got = Day3.solver1(input)
    assert want == got
  end
end
