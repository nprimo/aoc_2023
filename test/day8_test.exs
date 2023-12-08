defmodule Day8Test do
  use ExUnit.Case

  test "example 1 part 1" do
    input = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """

    want = 2
    got = Day8.Part1.solver(input)

    assert got == want
  end

  test "example 2 part 2" do
    input = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """

    want = 6
    got = Day8.Part1.solver(input)
    assert got == want
  end
end
