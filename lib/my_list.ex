defmodule MyList do
  def flatten(list), do: _flatten(list, [])

  defp _flatten([head | tail], result) when is_list(head) do
    initial = _flatten(head, result)
    final = _flatten(tail, result)
    initial ++ final
  end

  defp _flatten([], result) do
    result
  end

  defp _flatten([head | tail], result) do
    [head] ++ _flatten(tail, result)
  end
end
