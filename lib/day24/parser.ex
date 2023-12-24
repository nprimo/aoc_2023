defmodule Day24.Parser do
  def parse_input(input) do
    raw_points =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_row/1)

    raw_points
    |> Enum.map(fn p ->
      [[x, y, z], [v_x, v_y, v_z]] = p

      %{
        p: {x, y, z},
        v: {v_x, v_y, v_z},
        eq: point_to_equation(p)
      }
    end)
  end

  def parse_row(row) do
    row
    |> String.split(" @ ")
    |> Enum.map(fn info ->
      info
      |> String.split(", ", trim: true)
      |> Enum.map(fn v ->
        v
        |> String.trim()
        |> String.to_integer()
      end)
    end)
  end

  def point_to_equation([[x, y, _], [v_x, v_y, _]]) do
    # x = x1 + v_x1 * t
    # t = (x - x1) / v_x1

    # y = y1 + v_y1 * t
    # y = y1 + v_y1 * (x - x1) / v_x1 
    # y = y1 + v_y1 * x / v_x1 - v_y1 * x1 / v_x1 
    # y = x * (v_y1 / v_x1) + (y1 - v_y1 * x1 / v_x1) 
    {v_y / v_x, y - v_y * x / v_x}
  end
end
