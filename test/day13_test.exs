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

  @map_1 """
  #.##..##.
  ..#.##.#.
  ##......#
  ##......#
  ..#.##.#.
  ..##..##.
  #.#.##.#.
  """

  @map_2 """
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

  test "first map for part 1" do
    want = {5, nil}
    got = Day13.Part1.get_reflections(@map_1)

    assert got == want
  end

  test "second map for part 1" do
    want = {nil, 4}
    got = Day13.Part1.get_reflections(@map_2)

    assert got == want
  end

  test "is_vertical_reflection?" do
    row = "#.##..##."
    col_n = 5

    want = true
    got = Day13.Part1.is_vertical_reflection?(row, col_n)

    assert got == want
  end

  test "example for part 2" do
    want = 400
    got = Day13.Part2.solver(@input)

    assert got == want
  end

  test "first map for part 2" do
    want = {nil, 2}
    got = Day13.Part2.get_one_smudge_reflection(@map_1)

    assert got == want
  end

  test "second map for part 2" do
    want = {nil, 0}
    got = Day13.Part2.get_one_smudge_reflection(@map_2)

    assert got == want
  end
end
