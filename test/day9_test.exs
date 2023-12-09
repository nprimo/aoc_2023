defmodule Day9Test do
  use ExUnit.Case

  @input """
  0 3 6 9 12 15
  1 3 6 10 15 21
  10 13 16 21 30 45
  """

  test "example part1" do
    want = 114
    got = Day9.Part1.solver(@input)

    assert got == want
  end

  test "example part2" do
    want = 2
    got = Day9.Part2.solver(@input)

    assert got == want
  end
end
