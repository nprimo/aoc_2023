defmodule Day6.Part2 do
  def solver(input) do
    ["Time: " <> time_info, "Distance: " <> distance_info] =
      input
      |> String.split("\n", trim: true)

    [time_race, distance_race] =
      [time_info, distance_info]
      |> Enum.map(fn info ->
        info
        |> String.trim()
        |> String.split("\s", trim: true)
        |> Enum.join()
        |> String.to_integer()
      end)

    [lower_t, higher_t] =
      get_t_pressed_for_record(time_race, distance_race)

    (lower_t + 1)..(higher_t)
    |> Range.size()
  end

  # space = t_pressed * (total_time - t_pressed)
  # space = t_pressed * total_time - t_pressed ^ 2
  # - t_pressed ^ 2 + t_pressed * total_time - space = 0

  def get_t_pressed_for_record(total_time, distance) do
    [
      (-total_time + :math.sqrt(total_time ** 2 - 4 * distance)) / -2,
      (-total_time - :math.sqrt(total_time ** 2 - 4 * distance)) / -2
    ]
    |> Enum.map(&trunc/1)
  end
end
