defmodule Day22.Part1 do
  def solver(input) do
    bricks =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_brick/1)

    bricks
    |> dbg(charlists: :to_lists)
  end

  def parse_brick(row) do
    [p1, p2] =
      row
      |> String.split("~")
      |> Enum.map(fn point_str ->
        point_str
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.map(fn [x, y, z] ->
        {x, y, z}
      end)

    {
      elem(p1, 0)..elem(p2, 0),
      elem(p1, 1)..elem(p2, 1),
      elem(p1, 2)..elem(p2, 2)
    }
  end
end
