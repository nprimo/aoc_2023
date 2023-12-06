defmodule Day6Test do
  use ExUnit.Case

  @input """
  Time:      7  15   30
  Distance:  9  40  200
  """

  test "example part 1" do
    want = 288
    got = Day6.Part1.solver(@input)

    assert got == want
  end

  test "example part 2" do
    want = 71503 
    got = Day6.Part2.solver(@input)

    assert got == want
  end
end
