defmodule GameOfLife do
  
  # sample initial cells [[:live, :live, :dead], [:dead, :dead, :live], [:dead, :live, :dead]]

  defp next_state(:live, 2), do: :live
  defp next_state(:live, 3), do: :live
  defp next_state(:dead, 2), do: :live
  defp next_state(_, _), do: :dead

  def number_neighbours({ x, y }, cells) do
    list = [{ x - 1, y - 1}, {x, y - 1}, {x + 1, y - 1},
            { x - 1, y}, {x + 1, y},
            { x - 1, y + 1}, {x, y + 1}, {x + 1, y + 1}]
    list |> Enum.map(fn cell -> state_of_cell(cell, cells) end) |> Enum.count(&(&1 == :live))
  end

  def evolution(cells) do
    size = length(cells)
    0..size - 1 |> Enum.to_list |> Enum.map(fn x -> calculate_row(x, cells) end)
  end

  defp calculate_row(x, cells) do
    size = length(cells)
    0..size - 1 |> Enum.to_list |> Enum.map(fn y -> calculate_cell_state({x, y}, cells) end)
  end

  defp calculate_cell_state(coordinates, cells) do
    next_state(state_of_cell(coordinates, cells), number_neighbours(coordinates, cells))
  end

  def state_of_cell({x, y}, cells) when (x >= 0 and y >= 0) do
    row = Enum.at cells, x, []
    Enum.at row, y, :dead
  end
  def state_of_cell({x, y}, cells), do: :dead

end
