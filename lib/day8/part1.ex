defmodule Day8.Part1 do
  def solver(input) do
    [map, instructions_cycle] = parse_input(input) 
    walk("AAA", map, instructions_cycle)
  end

  def walk(point, map, instructions_cycle, step \\ 0)
  def walk("ZZZ", _map, _instructions_cycle, step), do: step

  def walk(point, map, instructions_cycle, step) do
    dir = Enum.at(instructions_cycle, step)

    new_point =
      if dir == "R" do
        Map.get(map, point).right
      else
        Map.get(map, point).left
      end

    walk(new_point, map, instructions_cycle, step + 1)
  end

  def parse_input(input) do
    [instructions | node_info] =
      input
      |> String.split("\n", trim: true)

    map =
      node_info
      |> Enum.map(fn <<
                       point::binary-size(3),
                       " = (",
                       left::binary-size(3),
                       ", ",
                       right::binary-size(3),
                       _::bits
                     >> ->
        {point, %{left: left, right: right}}
      end)
      |> Map.new()

    instructions_cycle =
      instructions
      |> String.graphemes()
      |> Stream.cycle()

    [map, instructions_cycle]
  end
end
