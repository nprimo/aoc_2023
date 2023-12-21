defmodule Day20Test do
  use ExUnit.Case

  test "example 1 part 1" do
    input = """
    broadcaster -> a, b, c
    %a -> b
    %b -> c
    %c -> inv
    &inv -> a
    """

    want = 32_000_000
    got = Day20.Part1.solver(input)

    assert got == want
  end

  @tag :skip
  test "example 2 part 2" do
    input = """
    broadcaster -> a
    %a -> inv, con
    &inv -> b
    %b -> con
    &con -> output 
    """

    want = 11_687_500
    got = Day20.Part1.solver(input)

    assert got == want
  end
end
