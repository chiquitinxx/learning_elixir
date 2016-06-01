defmodule LearningElixirTest do
  use ExUnit.Case
  doctest LearningElixir

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "working with functions" do
    assert 5 == sum 3, 2
    assert 4 == plus_one 3
    plus_one_list = 3..5 |> Enum.to_list |> Enum.map(&plus_one/1)
    assert plus_one_list == [4, 5, 6]
  end

  defp sum(a, b) do
    a + b
  end

  defp plus_one(a) do
    a + 1
  end
end
