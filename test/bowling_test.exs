defmodule BowlingTest do
  use ExUnit.Case

  @zero [{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}]
  @initial [{1, 0}, {3, 2}, {0, 0}, {0, 0}, {5, 1}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 8}]
  @spear [{1, 0}, {3, 2}, {0, 0}, {0, 0}, {5, 1}, {0, 0}, {5, 5}, {4, 0}, {0, 0}, {0, 8}]
  @strike [{1, 0}, {3, 2}, {0, 0}, {0, 0}, {5, 1}, {0, 0}, {10, 0}, {4, 2}, {0, 0}, {0, 8}]
  @strike2 [{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {10, 0}, {10, 0}, {2, 1}, {0, 0}]
  @strike_all [{10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}, {10, 0}]
  @end_spare [{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {5, 5}, {3, 0}]
  @end_spare_strike [{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {5, 5}, {10, 0}]
  @end_strikes [{0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {10, 0}, {10, 0}, {10, 0}, {2, 0}]

  test "testing bowling match points" do
    assert bowling_points([]) == 0
    assert bowling_points(@zero) == 0
    assert bowling_points(@initial) == 20
    assert bowling_points(@spear) == 38
    assert bowling_points(@strike) == 42
    assert bowling_points(@strike2) == 38
    assert bowling_points(@strike_all) == 300
    assert bowling_points(@end_spare) == 13
    assert bowling_points(@end_spare_strike) == 20
    assert bowling_points(@end_strikes) == 52
  end

  def bowling_points(match) do
    bowling_points(match, 0)
  end

  defp bowling_points([{10, _}, _], amount) do
    amount
  end

  defp bowling_points([{first, second}, {third, _}], amount) when first + second == 10 do
    amount + first + second + third
  end

  defp bowling_points([{10, _} , {10, _}, frame | rest], amount) do
    bowling_points([{10, 0}] ++ [frame] ++ rest, amount + 20 + elem(frame, 0))
  end

  defp bowling_points([{10, _} , frame | rest], amount) do
    bowling_points([frame] ++ rest, amount + 10 + elem(frame, 0) + elem(frame, 1))
  end

  defp bowling_points([{first, second} , frame | rest], amount) when first + second == 10 do
    bowling_points([frame] ++ rest, amount + first + second + elem(frame, 0))
  end

  defp bowling_points([{first, second} | rest], amount) do
    bowling_points(rest, amount + first + second)
  end

  defp bowling_points([], amount) do
    amount
  end
end
