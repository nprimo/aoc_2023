defmodule Day9Test do
  use ExUnit.Case

  test "example part1" do
    input = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

    want = 114
    got = Day9.Part1.solver(input)

    assert got == want
  end
end
