defmodule Day20.Part1 do
  import Day20.Parser
  alias Day20.Module, as: Module

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

    push_button(modules, 1000)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.reduce(1, fn x, acc -> x * acc end)
  end

  def final_count(modules) do
    freq =
      modules
      |> Enum.map(&(GenServer.call(&1, :status) |> Map.get(:history)))
      |> List.flatten()
      |> Enum.frequencies()

    freq
    |> Map.values()
    |> Enum.reduce(1, fn x, acc -> x * acc end)
    |> dbg()
  end

  def push_button(modules, n \\ 1, history \\ [])
  def push_button(_, 0, history), do: history

  def push_button(modules, n, history) do
    history =
      propagate_signal([{"button", "broadcaster", :l}], modules, [])
      |> Enum.concat(history)

    # IO.puts("\n #{n} \n")

    push_button(modules, n - 1, history)
  end

  def propagate_signal([], _, history), do: history

  def propagate_signal(signals, modules, history) do
    # dbg(signals)

    history =
      signals
      |> Enum.map(&elem(&1, 2))
      |> Enum.concat(history)

    {conn_targets, rest_targets} =
      signals
      |> Enum.split_with(fn {_, target, _} ->
        mod_name = target |> String.to_atom()

        if Enum.any?(modules, &(&1 == mod_name)) do
          GenServer.call(mod_name, {:get, :type}) == "conn"
        end
      end)

    # might not be required to do first conn and then the others
    new_targets =
      [conn_targets, rest_targets]
      |> Enum.map(fn targets ->
        targets
        |> Enum.map(fn {from, target, signal} ->
          mod_name = target |> String.to_atom()

          if Enum.any?(modules, &(&1 == mod_name)) do
            GenServer.call(mod_name, {:signal, from, signal})
          else
            []
          end
        end)
      end)
      |> List.flatten()

    propagate_signal(new_targets, modules, history)
  end
end
