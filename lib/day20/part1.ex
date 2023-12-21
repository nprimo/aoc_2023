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
          info |> Map.delete(:name),
          name: info.name |> String.to_atom()
        )

        info.name |> String.to_atom()
      end)

    propagate_signal([{"broadcaster", :l}])

    final_count(modules)
  end

  def final_count(modules) do
    [l, h] =
      modules
      |> Enum.map(&(GenServer.call(&1, :status) |> Map.get(:history)))
      |> List.flatten()
      |> Enum.frequencies()
      |> Map.values()

    l * h
  end

  def propagate_signal([]), do: nil

  def propagate_signal(target_signal) do
    dbg(target_signal)

    new_targets =
      target_signal
      |> Enum.map(fn {target, signal} ->
        mod_name = target |> String.to_atom()
        GenServer.call(mod_name, {:signal, signal})
      end)
      |> List.flatten()

    propagate_signal(new_targets)
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
  def handle_call(:last_signal, _from, state) do
    last_signal = state |> Map.get(:history) |> List.last()

    {
      :reply,
      if(!is_nil(last_signal), do: last_signal, else: :l),
      state
    }
  end

  @impl true
  def handle_call({:signal, signal}, _from, state) do
    # update history - for all cases
    new_state =
      state
      |> Map.update!(:history, &(&1 ++ [signal]))

    type =
      state
      |> Map.get(:type)

    [new_state, new_signal] =
      case type do
        "ff" ->
          if signal == :h do
            [new_state, nil]
          else
            new_state =
              new_state
              |> Map.update!(:on, &(!&1))

            if state |> Map.get(:on) do
              [new_state, :l]
            else
              [new_state, :h]
            end
          end

        "conn" ->
          # target =
          # state
          # |> Map.get(:target)

          source =
            state
            |> Map.get(:source)

          # [target, source]
          # |> Enum.concat()
          all_high? =
            source
            |> Enum.map(&String.to_atom/1)
            |> Enum.map(&GenServer.call(&1, :last_signal))
            |> Enum.all?(&(&1 == :h))

          if all_high? do
            [new_state, :l]
          else
            [new_state, :h]
          end

        _ ->
          [new_state, signal]
      end

    targets =
      if new_signal != nil do
        state
        |> Map.get(:target)
        |> Enum.map(&{&1, new_signal})
      else
        []
      end

    {:reply, targets, new_state}
  end
end
