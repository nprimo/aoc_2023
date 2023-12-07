defmodule Day7Test do
  use ExUnit.Case

  @input """
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  """

  test "example part 1" do
    want = 6440
    got = Day7.Part1.solver(@input)

    assert got == want
  end
end
