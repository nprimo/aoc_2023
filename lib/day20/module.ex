defmodule Day20.Module do
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
  def handle_call({:signal, from, signal}, _from, state) do
    type =
      state
      |> Map.get(:type)

    [state, new_signal] =
      case type do
        "ff" -> signal_ff(state, signal)
        "conn" -> signal_cc(state, from, signal)
        _ -> [state, signal]
      end

    targets =
      if new_signal != nil do
        state =
          state
          |> Map.update!(:signal, fn _ -> new_signal end)

        state
        |> Map.get(:target)
        |> Enum.map(&{state |> Map.get(:name), &1, new_signal})
      else
        []
      end

    {:reply, targets, state}
  end

  def signal_cc(mod, from, signal) do
    mod =
      mod
      |> Map.update!(:source, fn source ->
        source
        |> Map.put(from, signal)
      end)

    all_high? =
      mod
      |> Map.get(:source)
      |> Map.values()
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
