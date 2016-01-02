defmodule Hello do
   def print(value), do: IO.puts value

   def fizzbuzz(number) do
     1..number |> Enum.to_list |> Enum.each &fb/1
   end

   defp fb(x) when rem(x, 15) == 0, do: print("FizzBuzz")
   defp fb(x) when rem(x, 3) == 0, do: print("Fizz")
   defp fb(x) when rem(x, 5) == 0, do: print("Buzz")
   defp fb(x), do: print(x)
end
