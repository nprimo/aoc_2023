defmodule Day12Test do
  use ExUnit.Case

  @input """
  ???.### 1,1,3
  .??..??...?##. 1,1,3
  ?#?#?#?#?#?#?#? 1,3,1,6
  ????.#...#... 4,1,1
  ????.######..#####. 1,6,5
  ?###???????? 3,2,1
  """

   test "example part 1" do
   want = 21
   got = Day12.Part1.solver(@input)

   assert got == want
   end

  test "possible words" do
    row_raw = "???.###"
    info = [1, 1, 3]

    Day12.Part1.possible_rows(row_raw, info)
  end
end
