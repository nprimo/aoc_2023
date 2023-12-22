defmodule Day20.Part2 do
  import Day20.Part1
  import Day20.Parser

  def solver(input) do
    modules_info =
      input
      |> to_modules()

    modules =
      modules_info
      |> Enum.map(fn info ->
        GenServer.start_link(
          Module,
          info,
          name: info.name |> String.to_atom()
        )

        info.name |> String.to_atom()
      end)

    mod_to_check =
      modules
      |> Enum.filter(fn mod ->
        target =
          GenServer.call(mod, {:get, :target})

        target
        |> Enum.any?(&(&1 == "rx"))
      end)
      |> List.first()

    push_till_rx_low(modules, mod_to_check)
  end

  def push_till_rx_low(modules, mod_to_check, n \\ 1) do
    IO.puts(n)
    propagate_signal([{"button", "broadcaster", :l}], modules, [])

    if GenServer.call(mod_to_check, {:get, :signal}) == :l do
      n
    else
      push_till_rx_low(modules, mod_to_check, n + 1)
    end
  end
end
