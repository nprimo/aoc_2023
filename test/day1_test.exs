defmodule Day1Test do
  use ExUnit.Case

  @example_input_1 """
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
  """

  @example_input_2 """
  two1nine
  eightwothree
  abcone2threexyz
  xtwone3four
  4nineeightseven2
  zoneight234
  7pqrstsixteen
  """

  test "example part 1" do
    got = Day1.decrypt_calibration_1(@example_input_1)
    want = 142
    assert got == want
  end

  test "example part 2" do
    got = Day1.decrypt_calibration_2(@example_input_2)
    want = 281
    assert got == want
  end
end
