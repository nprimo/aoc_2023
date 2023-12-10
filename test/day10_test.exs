defmodule Day10Test do
  use ExUnit.Case

  test "example 1 part 1" do
    input = """
    .....
    .S-7.
    .|.|.
    .L-J.
    .....
    """

    want = 4
    got = Day10.Part1.solver(input)

    assert got == want
  end

  test "example 2 part q" do
    input = """
    ..F7.
    .FJ|.
    SJ.L7
    |F--J
    LJ...
    """

    want = 8
    got = Day10.Part1.solver(input)

    assert got == want
  end
end
