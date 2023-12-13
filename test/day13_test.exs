defmodule Day13Test do
  use ExUnit.Case

  @input """
  #.##..##.
  ..#.##.#.
  ##......#
  ##......#
  ..#.##.#.
  ..##..##.
  #.#.##.#.

  #...##..#
  #....#..#
  ..##..###
  #####.##.
  #####.##.
  ..##..###
  #....#..#
  """

  test "example part 1" do
    want = 405
    got = Day13.Part1.solver(@input)

    assert got == want
  end

  test "one map for part 1" do
    input = """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.
    """

    want = {5, nil}
    got = Day13.Part1.get_reflections(input)

    assert got == want
  end

  test "second map for part 1" do
    input = """
    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """

    want = {nil, 4}
    got = Day13.Part1.get_reflections(input)

    assert got == want
  end

  test "is_vertical_reflection?" do
    row = "#.##..##."
    col_n = 5

    want = true
    got = Day13.Part1.is_vertical_reflection?(row, col_n)

    assert got == want
  end
end
