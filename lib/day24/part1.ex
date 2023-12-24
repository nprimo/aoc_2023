defmodule Day24.Part1 do
  import Day24.Parser
  import Day11.RC

  @limits {200_000_000_000_000, 400_000_000_000_000}

  def solver(input, limits \\ @limits) do
    points =
      input
      |> parse_input

    points_comb =
      comb(2, 0..(length(points) - 1) |> Range.to_list())

    points_comb
    |> Enum.map(fn [pos1, pos2] ->
      p1 = points |> Enum.at(pos1)
      p2 = points |> Enum.at(pos2)

      int = intersection(p1.eq, p2.eq)

      {int, interseciton_time(int, p1, p2)}
    end)
    |> Enum.filter(fn {p, time} -> time > 0 and is_inside?(p, limits) end)
    |> length()
  end

  def interseciton_time(nil, _, _), do: nil

  def interseciton_time(int, p1, p2) do
    # c = c0 + v * t
    # t = (c - c0) / v

    {x_int, _} = int

    {x_p1, _, _} = p1.p
    {v_x1, _, _} = p1.v

    {x_p2, _, _} = p2.p
    {v_x2, _, _} = p2.v

    t_1 = (x_int - x_p1) / v_x1
    t_2 = (x_int - x_p2) / v_x2

    Enum.min([t_1, t_2])
  end

  def intersection({a1, _}, {a1, _}), do: nil

  def intersection({a1, b1}, {a2, b2}) do
    x = (b2 - b1) / (a1 - a2)
    y = a1 * x + b1

    {x, y}
  end

  def is_inside?(nil, _), do: false

  def is_inside?({x, y}, {min_val, max_val}) do
    x >= min_val and x <= max_val and
      y >= min_val and y <= max_val
  end
end
