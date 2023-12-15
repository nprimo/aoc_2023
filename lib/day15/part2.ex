defmodule Day15.Part2 do
  import Day15.Part1

  def solver(input) do
    input
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.reduce(
      %{},
      fn code, acc ->
        [label, sign, num] = parse_code(code)
        box_n = label |> hash_algo()

        box =
          acc
          |> Map.get(box_n)

        case sign do
          "=" ->
            num = String.to_integer(num)

            new_box =
              update_box(box, label, num)

            acc
            |> Map.put(box_n, new_box)

          "-" ->
            new_box =
              remove_lable_from_box(box, label)

            acc
            |> Map.put(box_n, new_box)
        end
      end
    )
    |> Map.to_list()
    |> Enum.reduce(0, fn {box_n, lenses}, acc ->
      acc + calc_box_total(box_n, lenses)
    end)
  end

  def parse_code(code) do
    if String.contains?(code, "=") do
      [label, num] =
        code
        |> String.split("=")

      [label, "=", num]
    else
      label =
        code
        |> String.slice(0..-2)

      sign = String.last(code)

      [label, sign, nil]
    end
  end

  def calc_box_total(_, []), do: 0

  def calc_box_total(box_n, lenses) do
    lenses
    |> Enum.slice(1..-1//2)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {focal_len, slot_n}, acc ->
      calc_focus_power(box_n, slot_n, focal_len) + acc
    end)
  end

  def calc_focus_power(box_n, slot_n, focal_len) do
    (box_n + 1) * (slot_n + 1) * focal_len
  end

  def remove_lable_from_box(nil, _), do: []

  def remove_lable_from_box(box, label) do
    pos_label =
      box
      |> Enum.find_index(&(&1 == label))

    if pos_label == nil do
      box
    else
      box
      |> List.delete_at(pos_label + 1)
      |> List.delete_at(pos_label)
    end
  end

  def update_box(box, label, num) do
    case box do
      nil ->
        [label, num]

      box ->
        pos_label =
          box
          |> Enum.find_index(&(&1 == label))

        if pos_label == nil do
          box ++ [label, num]
        else
          box
          |> List.replace_at(pos_label + 1, num)
        end
    end
  end
end
