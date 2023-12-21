defmodule Day21Test do
  use ExUnit.Case

  test "example part 1" do
    input = """
    ...........
    .....###.#.
    .###.##..#.
    ..#.#...#..
    ....#.#....
    .##..S####.
    .##..#...#.
    .......##..
    .##.#.####.
    .##..##.##.
    ...........
    """

    want = 16
    got = Day21.Part1.solver(input)

    assert got == want
  end
end
