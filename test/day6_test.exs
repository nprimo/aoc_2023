defmodule Day6Test do
  use ExUnit.Case

  test "example part 1" do
    input = """
    Time:      7  15   30
    Distance:  9  40  200
    """

    want = 288
    got = Day6.Part1.solver(input)

    assert got == want
  end
end
