defmodule Contest4 do
   @moduledoc "Tuenti contest 4"

   def pythagoras(filename) do
     file = File.read!(filename)
     lines = String.split(file, "\n")
     {number_tests, _} = List.first(lines) |> Integer.parse
     min_triangles(remove_empty_lines(Enum.drop(lines, 1)), 1, number_tests)
   end

   defp remove_empty_lines(list) do
      Enum.filter list, fn(x) -> x != "" end
   end

   defp min_triangles([row | rest], test_number, number_tests) do
     row_list = Enum.map(String.split(row, " "), &(Integer.parse(&1) |> elem(0)))
     number_sides = List.first(row_list)
     sorted_sides = Enum.drop(row_list, 1) |> Enum.sort
     IO.puts "Case #" <> Integer.to_string(test_number) <> ": " <> min_triangle_text(sorted_sides)
     min_triangles(rest, test_number + 1, number_tests)
   end

   defp min_triangles([], test_number, number_tests) do
     IO.puts "\nDone!"
   end

   defp min_triangle_text(sorted_sides) do
     case min_triangle_perimeter(sorted_sides) do
       {:ok, number} -> Integer.to_string(number)
       {:impossible} -> "IMPOSSIBLE"
     end
   end

   defp min_triangle_perimeter([]), do: {:impossible}
   defp min_triangle_perimeter([_]), do: {:impossible}
   defp min_triangle_perimeter([_, _]), do: {:impossible}

   defp min_triangle_perimeter(sides) do
     minimum = combinations(sides, {0, 1, Enum.count(sides) - 1, false}, :not_found)
     case minimum == :not_found do
       true -> {:impossible}
       false -> {:ok, minimum }
     end
   end

   defp is_triangle(first, second, third) do
     (first + second) > third
   end

   def combinations(_, {_, _, _, done}, minimum) when done == true do
     minimum
   end

   def combinations(sides, {i1, i2, _, _} = position, minimum) do
     #Enum.at is linear, so sloooooow, search for a index based list or a map :)
     first = Enum.at(sides, i1)
     second = Enum.at(sides, i2)
     third = Enum.at(sides, i2 + 1)
     sum = first + second + third
     got_triangle = is_triangle(first, second, third)
     next_position = get_next_position(position, got_triangle || sum >= minimum)
     case (got_triangle && minimum == :not_found) || (got_triangle && sum < minimum) do
       true -> combinations(sides, next_position, sum)
       false -> combinations(sides, next_position, minimum)
     end
   end

   def get_next_position({i1, i2, max, done}, change) when (i1 + 2) >= max and change == true do
     {i1, i2, max, true}
   end

   def get_next_position({i1, i2, max, done}, change) when (i1 + 2) >= max and (i2 + 1) >= max do
     {i1, i2, max, true}
   end

   def get_next_position({i1, i2, max, done}, change) when change == true do
     {i1 + 1, i1 + 2, max, false}
   end

   def get_next_position({i1, i2, max, done}, change) when (i2 + 1) >= max do
     {i1 + 1, i1 + 2, max, false}
   end

   def get_next_position({i1, i2, max, done}, change) do
     {i1, i2 + 1, max, false}
   end

end
