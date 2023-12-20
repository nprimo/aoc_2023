defmodule Day20.Part1 do
  @doc """
  > Ignore "high pulse"
  > When receive "low pules"
  - if it was off, turn on and send high signal
  - if it was on, turn off and send low signal
  """

  @doc """
  Remember the type of the impulse received from each of their connected model
  > Inital state - all low 
  > When new pulse received
  - first update memory
  - if all "high", send low
  - else send "high"
  """

  def solver(input) do
    modules =
      input
      |> to_modules()
      |> dbg()
  end

  def push_button(modules) do
  end

  def to_modules(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_row/1)
    |> Map.new(fn mod ->
      {mod.name, Map.drop(mod, [:name])}
    end)
    |> update_conn_modules()
  end

  def update_conn_modules(modules) do
    conn_names =
      modules
      |> Map.filter(fn {_, v} -> v.type == "conn" end)
      |> Map.keys()

    conn_to_sources =
      conn_names
      |> Enum.reduce(%{}, fn mod, acc ->
        source_names =
          modules
          |> Map.filter(fn {_, v} ->
            Enum.any?(v.target, &(&1 == mod))
          end)
          |> Map.keys()
          |> Enum.reduce(%{}, fn k, acc -> 
            Map.put(acc, k, :low)
          end)

        Map.put(acc, mod, source_names)
      end)

    do_update_conn_modules(conn_names, conn_to_sources, modules)
  end

  def do_update_conn_modules([], _, modules), do: modules

  def do_update_conn_modules([conn_name | rest], conn_to_sources, modules) do
    modules =
      modules
      |> Map.update(conn_name, %{}, fn mod ->
        Map.update(mod, :source, [], fn _ ->
          Map.get(conn_to_sources, conn_name)
        end)
      end)

    do_update_conn_modules(rest, conn_to_sources, modules)
  end

  def parse_row(row) do
    [name_info, dest_info] =
      row
      |> String.split(" -> ")

    dest =
      dest_info
      |> String.split(", ")

    [type, name] =
      case name_info do
        "broadcaster" -> [nil, name_info]
        <<symbol::binary-size(1), name::bits>> -> [symbol, name]
      end

    case type do
      nil ->
        %{
          name: name,
          target: dest,
          type: "broad",
          history: []
        }

      "%" ->
        %{
          name: name,
          target: dest,
          on: false,
          type: "ff",
          history: []
        }

      "&" ->
        %{
          name: name,
          target: dest,
          source: [],
          type: "conn",
          history: []
        }
    end
  end
end
