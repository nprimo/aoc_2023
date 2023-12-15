defmodule Day15Test do
  use ExUnit.Case

  @input """
  rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
  """

  test "example part 2" do
    want = 145
    got = Day15.Part2.solver(@input)
    assert got == want
  end
  test "example part 1" do
    want = 1320
    got = Day15.Part1.solver(@input)

    assert got == want
  end

  test "HASH word" do
    input = "HASH"

    want = 52
    got = Day15.Part1.hash_algo(input)

    assert got == want
  end

  test "rn=1 word" do
    input = "rn=1"

    want = 30
    got = Day15.Part1.hash_algo(input)

    assert got == want
  end
end
