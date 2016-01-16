defmodule Urls do

  def short(url, prefix) do
  	small = url
  	  |> Urls.reduce
  	  |> Urls.compose
  	prefix <> small
  end

  def reduce(str) when is_binary(str) do
    _to_number(str, 0, 0)
  end

  defp _to_number(<<>>, acc, pos), do: acc
  defp _to_number(<< head::utf8, tail::binary >>, acc, pos) when pos == 0 do
    _to_number(tail, head + acc, pos + 1)
  end
  defp _to_number(<< head::utf8, tail::binary >>, acc, pos) do
    _to_number(tail, (head * 10 * pos) + acc, pos + 1)
  end

  def compose(number) when is_number(number) do
    number
      |> to_string
      |> String.codepoints
      |> _compose("")
  end

  defp _compose([], acc), do: acc
  defp _compose([first], acc) do
  	valid_char(first) <> acc
  end
  defp _compose([first , second | tail], acc) do
    _compose(tail, valid_char(first <> second) <> acc)
  end

  defp valid_char(str) do
    number = str
     |> Integer.parse
     |> elem(0)
     |> rem(26)
    << (number + 97)::utf8 >>
    # The same
    #{val, _} = Integer.parse(str)
    #<< (rem(val, 26) + 97)::utf8 >>
  end
end