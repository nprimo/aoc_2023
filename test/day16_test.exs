defmodule Day16Test do
  use ExUnit.Case

  @input ~S"""
  .|...\....
  |.-.\.....
  .....|-...
  ........|.
  ..........
  .........\
  ..../.\\..
  .-.-/..|..
  .|....-|.\
  ..//.|....
  """

  test "example part 1" do
    want = 46
    got = Day16.Part1.solver(@input)

    assert got == want
  end
end
