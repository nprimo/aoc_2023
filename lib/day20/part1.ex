defmodule Day20.Part1.Module do
  

  def start_link(initial_values) do
    {:ok, pid} = Agent.start_link(fn -> initial_values end)
    pid
  end

  def get(pid) do
    Agent.get(pid, & &1) 
  end

  def send_signal(pid, signal) do 
    Agent.update(pid, fn mod -> 
      mod
      |> Map.update!(:history, & &1 ++ [signal])
    end) 
  end

end

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
        {info.name, Module.start_link(info |> Map.delete(:name))}
      end)
      |> Map.new()

    modules
    |> Map.get("a")
    |> Module.send_signal(:l)

    modules
    |> Map.get("a")
    |> Module.get
  end
end
