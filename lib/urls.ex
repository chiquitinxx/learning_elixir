defmodule Urls do

  def short_url(url) do
  	url
  	  |> Urls.reduce
  	  |> Urls.compose
  end

  def similar_short_url(short_url) do
    short_url <> random_char
  end

  def random_char() do
    number = :random.uniform(26) - 1
  	letter_char(number)
  end

  def reduce(str) when is_binary(str) do
    _to_number(str, 0, 0)
  end

  defp _to_number(<<>>, acc, _), do: acc
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
    str
      |> Integer.parse
      |> elem(0)
      |> letter_char
    # The same
    #{val, _} = Integer.parse(str)
    #<< (rem(val, 26) + 97)::utf8 >>
  end

  defp letter_char(number) do
    valid_char_number = rem(number, 26)
    << (valid_char_number + 97)::utf8 >>
  end
end