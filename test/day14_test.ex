defmodule Day14Test do
  use ExUnit.Case

  import Day14.Part1

  @input """
  O....#....
  O.OO#....#
  .....##...
  OO.#O....O
  .O.....O#.
  O.#..O.#.#
  ..O..#O..O
  .......O..
  #....###..
  #OO..#....
  """

  test "example part 1" do
    got = solver(@input)
    want = 136

    assert got == want
  end

  test "column after tilt" do
    col = ".#.O.#O..."

    want = ".#O..#O..."
    got = tilt_col(col)

    assert got == want
  end

  test "column after tilt - 2" do
    col = "#.#..O#.##"

    want = "#.#O..#.##"
    got = tilt_col(col)

    assert got == want
  end
end
