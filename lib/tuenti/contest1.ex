defmodule Contest1 do
   @moduledoc "Tuenti contest 1"

   @portions_by_pizza 8

   def buy_pizzas(filename) do
     file = File.read!(filename)
     lines = String.split(file, "\n")
     {number_tests, _} = Enum.at(lines, 0) |> Integer.parse
     calculate_number_pizzas(remove_empty_lines(Enum.drop(lines, 1)), 1, number_tests)
   end

   defp remove_empty_lines(list) do
      Enum.filter list, fn(x) -> x != "" end
   end

   defp calculate_number_pizzas([people, maxs | rest], test_number, number_tests) do
     {number_persons, _} = Integer.parse people
     list_maximums = String.split(maxs, " ")
     sum_maximums = Enum.map(list_maximums, fn(x) -> elem(Integer.parse(x), 0) end) |> Enum.sum
     IO.puts "Case #" <> Integer.to_string(test_number) <> ": " <> Integer.to_string(get_number_pizzas(sum_maximums))
     calculate_number_pizzas(rest, test_number + 1, number_tests)
   end

   defp calculate_number_pizzas([], test_number, number_tests) when test_number != (number_tests + 1) do
     IO.puts "Executed more tests that expected"
   end

   defp calculate_number_pizzas([], test_number, number_tests) do
     IO.puts "\nDone!"
   end

   defp get_number_pizzas(needed_portions) do
     module = Integer.mod(needed_portions, @portions_by_pizza)
     case module do
       0 -> Integer.floor_div(needed_portions, @portions_by_pizza)
       _ -> Integer.floor_div(needed_portions, @portions_by_pizza) + 1
     end
   end
end
