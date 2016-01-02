defmodule GameOfLifeTest do
  use ExUnit.Case

  test "state of cells" do
    cells = [
      [:dead, :live, :dead],
      [:dead, :dead, :dead],
      [:dead, :live, :dead]
    ]
    assert GameOfLife.state_of_cell({0, 0}, cells) == :dead
    assert GameOfLife.state_of_cell({0, 1}, cells) == :live
    assert GameOfLife.state_of_cell({1, 0}, cells) == :dead
    assert GameOfLife.state_of_cell({2, 1}, cells) == :live
    assert GameOfLife.state_of_cell({-1, -1}, cells) == :dead
    assert GameOfLife.state_of_cell({-1, 0}, cells) == :dead
    assert GameOfLife.state_of_cell({0, -1}, cells) == :dead
    assert GameOfLife.state_of_cell({-1, 1}, cells) == :dead
    assert GameOfLife.state_of_cell({1, -1}, cells) == :dead
  end

  test "number of neighbours" do
      cells = [
        [:dead, :live, :dead],
        [:dead, :dead, :dead],
        [:dead, :live, :dead]
      ]
      assert GameOfLife.number_neighbours({0, 0}, cells) == 1
      assert GameOfLife.number_neighbours({0, 2}, cells) == 1
    end

  test "evolution of three line cells" do
    cells = [
      [:dead, :live, :dead],
      [:dead, :dead, :dead],
      [:dead, :live, :dead]
    ]
    assert GameOfLife.evolution(cells) == [
      [:dead, :dead, :dead],
      [:live, :live, :live],
      [:dead, :dead, :dead]
    ]
  end
end
