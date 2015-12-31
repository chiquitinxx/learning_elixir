defmodule Chop do
  defp try_message(x) do
    IO.puts "Try #{x}"
  end
  def guess(number, initial..final) do
    try(number, middle(initial, final), initial, final)
  end
  defp try(number, key, _, top) when number > key do
    try_message key
    try(number, middle(key, top), key, top)
  end
  defp try(number, key, bottom, _) when number < key do
    try_message key
    try(number, middle(bottom, key), bottom, key)
  end
  defp try(number, key, _, _) when number == key do
    IO.puts "Got it #{number}!"
  end
  defp middle(initial, final) do
    div(final + initial, 2)
  end
end
