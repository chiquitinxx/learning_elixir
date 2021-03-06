defmodule Fizzbuzz do
   @moduledoc "Fizzbuzz demo"
   def fizzbuzz(number) when number < 1, do: []

   def fizzbuzz(number) do
     1..number |> Enum.map(&fb/1)
   end

   defp fb(x) when rem(x, 15) == 0, do: "FizzBuzz"
   defp fb(x) when rem(x, 3) == 0, do: "Fizz"
   defp fb(x) when rem(x, 5) == 0, do: "Buzz"
   defp fb(x), do: x
end
