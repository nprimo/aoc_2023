defmodule Day20.Parser do
  def to_modules(input) do
    modules =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_row/1)

    modules
    |> update_conn()
  end

  def update_conn(modules) do
    name_conn =
      modules
      |> Enum.filter(&(&1.type == "conn"))
      |> Enum.map(& &1.name)

    source_conn_map =
      name_conn
      |> Enum.map(fn name ->
        modules
        |> Enum.filter(fn mod ->
          Enum.any?(mod.target, &(&1 == name))
        end)
        |> Enum.map(&{&1.name, name})
      end)
      |> List.flatten()

    update_conn_source(source_conn_map, modules)
  end

  def update_conn_source([], modules), do: modules

  def update_conn_source([{source, conn} | rest], modules) do
    modules =
      modules
      |> Enum.map(fn mod ->
        if mod.name == conn do
          mod
          |> Map.update(:source, [], fn curr -> Map.put(curr, source, :l) end)
        else
          mod
        end
      end)

    update_conn_source(rest, modules)
  end

  def parse_row(row) do
    [name_info, target_info] =
      row
      |> String.split(" -> ")

    target =
      target_info
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
          target: target,
          signal: nil,
          type: "broad"
        }

      "%" ->
        %{
          name: name,
          target: target,
          on: false,
          signal: nil,
          type: "ff"
        }

      "&" ->
        %{
          name: name,
          target: target,
          type: "conn",
          signal: nil,
          source: %{}
        }
    end
  end
end
