defmodule Day19.Part1 do
  def solver(input) do
    [workflows_info, parts_info] =
      input
      |> String.split("\n\n", trim: true)

    workflows =
      workflows_info
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_single_workflow/1)
      |> Enum.reduce(%{}, fn workflow, acc ->
        acc
        |> Map.put(workflow.name, workflow.rules)
      end)

    parts =
      parts_info
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_single_part/1)

    parts
    |> Enum.filter(fn part ->
      process_part(part, Map.get(workflows, "in"), workflows) == "A"
    end)
    |> Enum.map(&Map.values/1)
    |> List.flatten()
    |> Enum.reduce(fn x, acc -> x + acc end)
  end

  def process_part(part, rules, workflows) do
    [curr | rest] = rules

    final =
      process_rule(part, curr, workflows)

    case final do
      nil -> process_part(part, rest, workflows)
      "A" -> "A"
      "R" -> "R"
      dest -> process_part(part, Map.get(workflows, dest), workflows)
    end
  end

  def process_rule(_, %{cond: nil, dest: "A"}, _), do: "A"

  def process_rule(_, %{cond: nil, dest: "R"}, _), do: "R"

  def process_rule(part, %{cond: nil, dest: dest}, workflows),
    do: process_part(part, Map.get(workflows, dest), workflows)

  def process_rule(part, %{cond: cond, dest: dest}, workflows) do
    <<key::binary-size(1), sign::binary-size(1), num::bits>> = cond

    check =
      case sign do
        ">" -> Map.get(part, key) > String.to_integer(num)
        "<" -> Map.get(part, key) < String.to_integer(num)
      end

    if check do
      dest
    else
      nil
    end
  end

  def(parse_single_workflow(info)) do
    [name, rules, _] =
      ~r{(\{.+\})}
      |> Regex.split(info, include_captures: true)

    parsed_rules =
      rules
      |> String.slice(1..-2)
      |> String.split(",")
      |> Enum.map(&parse_rule/1)

    %{
      name: name,
      rules: parsed_rules
    }
  end

  def parse_rule(info) do
    [cond, dest] =
      if String.contains?(info, ":") do
        info |> String.split(":")
      else
        [nil, info]
      end

    %{cond: cond, dest: dest}
  end

  def parse_single_part(part_info) do
    part_info
    |> String.slice(1..-2)
    |> String.split(",")
    |> Enum.reduce(%{}, fn val, acc ->
      [key, num] = val |> String.split("=")

      acc
      |> Map.put(key, String.to_integer(num))
    end)
  end
end
