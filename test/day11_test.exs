defmodule Day11Test do
  use ExUnit.Case

  @input """
  ...#......
  .......#..
  #.........
  ..........
  ......#...
  .#........
  .........#
  ..........
  .......#..
  #...#.....
  """
  test "test part 1 example" do
    want = 374
    got = Day11.Part1.solver(@input)

    assert want == got
  end

  test "expand galaxy map part 1" do
    want = """
    ....#........
    .........#...
    #............
    .............
    .............
    ........#....
    .#...........
    ............#
    .............
    .............
    .........#...
    #....#.......
    """

    got =
      @input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist(&1))
      |> Nx.tensor(names: [:rows, :cols])
      |> Day11.Part1.get_expanded_galaxy()

    assert got |> String.trim_trailing() == want |> String.trim_trailing()
  end

  test "with galaxy expanded x10" do
    want = 1030
    got = Day11.Part2.solver(@input, 10)

    assert got == want
  end

  test "with galaxy expanded x100" do
    want = 8410
    got = Day11.Part2.solver(@input, 100)

    assert got == want
  end
end

