defmodule Day20.Part1 do
  import Day20.Parser
  alias Day20.Part1.Module, as: Module

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

    push_button(modules, 3)

    final_count(modules)
  end

  def push_button(modules, n \\ 1)
  def push_button(_, 0), do: nil

  def push_button(modules, n) do
    propagate_signal([{"broadcaster", :l}], modules)

    IO.puts("\n #{n} \n")

    push_button(modules, n - 1)
  end

  def final_count(modules) do
    [h, l] =
      modules
      |> Enum.map(&(GenServer.call(&1, :status) |> Map.get(:history)))
      |> List.flatten()
      |> Enum.frequencies()
      |> Map.values()

    dbg([l, h])
    l * h
  end

  def propagate_signal([], _), do: nil

  def propagate_signal(target_signal, modules) do
    dbg(target_signal)

    {conn_targets, rest_targets} =
      target_signal
      |> Enum.split_with(fn {target, _} ->
        mod_name = target |> String.to_atom()

        if Enum.any?(modules, &(&1 == mod_name)) do
          GenServer.call(mod_name, {:get, :type}) == "conn"
        end
      end)

    new_targets =
      [conn_targets, rest_targets]
      |> Enum.map(fn targets ->
        targets
        |> Enum.map(fn {target, signal} ->
          mod_name = target |> String.to_atom()

          if Enum.any?(modules, &(&1 == mod_name)) do
            GenServer.call(mod_name, {:signal, signal})
          else
            []
          end
        end)
      end)
      |> List.flatten()

    propagate_signal(new_targets, modules)
  end
end

defmodule Day20.Part1.Module do
  use GenServer

  @impl true
  def init(initial_values) do
    {:ok, initial_values}
  end

  @impl true
  def handle_call(:status, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, state |> Map.get(key), state}
  end

  @impl true
  def handle_call(:last_signal, _from, state) do
    last_signal = state |> Map.get(:signal)

    {
      :reply,
      if(!is_nil(last_signal), do: last_signal, else: :l),
      state
    }
  end

  @impl true
  def handle_call({:signal, signal}, _from, state) do
    state =
      state
      |> Map.update!(:history, &(&1 ++ [signal]))

    type =
      state
      |> Map.get(:type)

    [state, new_signal] =
      case type do
        "ff" -> signal_ff(state, signal)
        "conn" -> signal_cc(state)
        _ -> [state, signal]
      end

    state =
      state
      |> Map.update!(:signal, fn _ -> new_signal end)

    targets =
      if new_signal != nil do
        state
        |> Map.get(:target)
        |> Enum.map(&{&1, new_signal})
      else
        []
      end

    {:reply, targets, state}
  end

  def signal_cc(mod) do
    source_mod =
      mod
      |> Map.get(:source)
      |> Map.keys()

    all_high? =
      source_mod
      |> Enum.map(&String.to_atom/1)
      |> Enum.map(&GenServer.call(&1, :last_signal))
      |> Enum.all?(&(&1 == :h))

    if all_high? do
      [mod, :l]
    else
      [mod, :h]
    end
  end

  def signal_ff(mod, :h), do: [mod, nil]

  def signal_ff(mod, :l) do
    new_signal = if(mod |> Map.get(:on), do: :l, else: :h)

    [mod |> Map.update!(:on, &(!&1)), new_signal]
  end
end
