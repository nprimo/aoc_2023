defmodule Day2 do
  @max_values %{
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  def solver(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(fn game -> parse_game(game) end)
    |> get_valid_games_id([])
    |> Enum.reduce(0, fn id, acc -> id + acc end)
  end

  def solver2(input) do
    input
    |> String.trim_trailing()
    |> String.split("\n")
    |> Enum.map(fn game -> parse_game(game) end)
    |> Enum.map(fn game -> get_least_cubes(Map.get(game, "rounds")) end)
    |> Enum.reduce(0, fn id, acc -> id + acc end)
  end

  defp get_least_cubes(rounds) do
    max_green =
      rounds
      |> List.foldl([], fn round, acc -> acc ++ [Map.get(round, "green", 1)] end)
      |> Enum.max()

    max_red =
      rounds
      |> List.foldl([], fn round, acc -> acc ++ [Map.get(round, "red", 1)] end)
      |> Enum.max()

    max_blue =
      rounds
      |> List.foldl([], fn round, acc -> acc ++ [Map.get(round, "blue", 1)] end)
      |> Enum.max()

    max_green * max_blue * max_red
  end

  defp parse_game(""), do: %{}

  defp parse_game(game_str) do
    [game_head, round_info] =
      game_str
      |> String.split(": ")

    {game_id, _} =
      game_head
      |> String.split(" ")
      |> Enum.at(1)
      |> Integer.parse()

    rounds =
      round_info
      |> String.split("; ")
      |> parse_rounds([])

    %{"game_id" => game_id, "rounds" => rounds}
  end

  defp parse_rounds([], rounds), do: rounds

  defp parse_rounds([curr | rest], rounds) do
    rounds =
      [
        curr
        |> String.split(", ")
        |> parse_colors(%{})
      ] ++ rounds

    parse_rounds(rest, rounds)
  end

  defp parse_colors([], round), do: round

  defp parse_colors([curr | rest], round) do
    [quantity_raw, color] =
      curr
      |> String.split(" ")

    {quantity, _} = Integer.parse(quantity_raw)

    round = Map.put(round, color, quantity)
    parse_colors(rest, round)
  end

  defp get_valid_games_id([], valid_games), do: valid_games

  defp get_valid_games_id([curr | rest], valid_games) do
    is_valid =
      curr
      |> Map.get("rounds")
      |> is_valid?()

    case is_valid do
      true -> get_valid_games_id(rest, valid_games ++ [Map.get(curr, "game_id")])
      _ -> get_valid_games_id(rest, valid_games)
    end
  end

  defp is_valid?(rounds, result \\ true)
  defp is_valid?([], result), do: result

  defp is_valid?([curr | rest], result) do
    invalid_rounds =
      curr
      |> Map.keys()
      # Assume colors are always good in dict
      |> Enum.filter(fn color -> Map.get(curr, color) > Map.get(@max_values, color) end)
      |> length()

    if invalid_rounds > 0 do
      is_valid?([], false)
    else
      is_valid?(rest, result)
    end
  end
end
