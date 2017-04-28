defmodule Contest3 do
   @moduledoc "Tuenti contest 3"

   def cards(filename) do
     file = File.read!(filename)
     lines = String.split(file, "\n")
     {number_tests, _} = Enum.at(lines, 0) |> Integer.parse
     cards_needed(remove_empty_lines(Enum.drop(lines, 1)), 1, number_tests)
   end

   defp remove_empty_lines(list) do
      Enum.filter list, fn(x) -> x != "" end
   end

   defp cards_needed([number | rest], test_number, number_tests) do
     {maximum_number, _} = Integer.parse number
     IO.puts "Case #" <> Integer.to_string(test_number) <> ": " <> Integer.to_string(number_distinct_cards(maximum_number))
     cards_needed(rest, test_number + 1, number_tests)
   end

   defp cards_needed([], test_number, number_tests) do
     IO.puts "\nDone!"
   end

   defp number_distinct_cards(number) when number == 1 do
     1
   end

   defp number_distinct_cards(number) do
     get_equal_or_greater(4, 2, number)
   end

   defp get_equal_or_greater(max, count, number) do
     case max >= number  do
       true -> count
       false -> get_equal_or_greater(2 * max, count + 1, number)
     end
   end

end
