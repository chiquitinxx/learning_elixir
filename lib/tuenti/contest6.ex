defmodule Contest6 do
   @moduledoc "Tuenti contest 6"

   def tower(filename) do
     file = File.read!(filename)
     lines = String.split(file, "\n")
     {number_tests, _} = List.first(lines) |> Integer.parse
     go_up_tower(remove_empty_lines(Enum.drop(lines, 1)), 1, number_tests)
   end

   defp remove_empty_lines(list) do
      Enum.filter list, fn(x) -> x != "" end
   end

   defp split_to_numbers(line) do
     Enum.map(String.split(String.trim(line), " "), &(Integer.parse(&1) |> elem(0)))
   end

   defp go_up_tower([row | rest], test_number, number_tests) do
     #IO.puts "->" <> row
     [number_levels, number_shortcuts] = split_to_numbers(row)
     shortcuts = get_shortcuts(Enum.take(rest, number_shortcuts))
                 |> Enum.uniq
                 |> remove_repeated_initial_and_final
                 |> remove_worst_than_normal
                 |> Enum.sort &(&1.initial < &2.initial || &1.final < &2.final)
     map_shortcuts = precalculate_shortcuts(shortcuts, number_levels)
     IO.puts "Case #" <> Integer.to_string(test_number) <> ": " <> Integer.to_string(minimum_path(number_levels, map_shortcuts))
     go_up_tower(Enum.drop(rest, number_shortcuts), test_number + 1, number_tests)
   end

   defp remove_repeated_initial_and_final(shortcuts) do
     grouped_shortcuts = Enum.group_by(shortcuts, fn(x) -> {x.initial, x.final} end, fn(x) -> x.time end)
     Enum.map(grouped_shortcuts, fn({{initial, final}, times}) ->
       minimal_time = Enum.min(times)
       %{:initial => initial, :final => final, :time => minimal_time}
     end)
   end

   defp remove_worst_than_normal(shortcuts) do
     Enum.filter shortcuts, fn(shortcut) ->
       Enum.sum((shortcut.initial)..(shortcut.final - 1)) > shortcut.time
     end
   end

   defp go_up_tower([], test_number, number_tests) do
     IO.puts "\nDone!"
   end

   defp get_shortcuts(shortcut_text_lines) do
     Enum.map shortcut_text_lines, fn(row) ->
       [initial, final, time] = split_to_numbers(row)
       %{:initial => initial, :final => final, :time => time}
     end
   end

   defp minimum_path(1, _) do
     0
   end

   defp minimum_path(number_levels, []) do
     Enum.sum 1..(number_levels - 1)
   end

   defp minimum_path(number_levels, map_shortcuts) do
     better_path(1, number_levels, map_shortcuts, elem(Agent.start_link(fn -> %{} end), 1), 0)
   end

   defp better_path(level, number_levels, _, _, acc) when level == number_levels do
     acc
   end

   defp better_path(level, number_levels, map_shortcuts, cache, acc) do

     level_shortcuts = Map.get(map_shortcuts, level)

     case info_shortcuts(level_shortcuts, level) do
       :empty -> better_path_to_next_or_end(level, number_levels, map_shortcuts, cache, acc)
       :any_smaller_that_current_level -> better_path_shortcuts(level_shortcuts.list, number_levels, map_shortcuts, cache, acc)
       :normal -> better_path_shortcuts(level_shortcuts.list ++ [%{:initial => level, :final => level + 1, :time => level}], number_levels, map_shortcuts, cache, acc)
     end
   end

   defp better_path_to_next_or_end(level, number_levels, map_shortcuts, cache, acc) do
     next = Enum.min Enum.filter(Map.keys(map_shortcuts), &(&1 > level)), fn -> number_levels end
     time = Enum.sum level..(next - 1)
     better_path(next, number_levels, map_shortcuts, cache, acc + time)
   end

   defp better_path_shortcuts(shortcuts, number_levels, map_shortcuts, cache, acc) do
     shortcuts
       |>Enum.map(fn(shortcut) ->
         key = key_for_shortcut(shortcut)
         value = Agent.get(cache, fn map -> Map.get(map, key) end)
         if (value == nil) do
           value = better_path(shortcut.final, number_levels, map_shortcuts, cache, acc + shortcut.time)
           Agent.update(cache, fn map -> Map.put(map, key, value - acc) end)
           value
         else
            acc + value
         end
       end)
       |> Enum.min
   end

   defp info_shortcuts(nil, _), do: :empty
   defp info_shortcuts(%{:list => [], :min => _}, level), do: :empty
   defp info_shortcuts(level_shortcuts, level) do
     if (level_shortcuts.min <= level) do
        :any_smaller_that_current_level
     else
        :normal
     end
   end

   defp precalculate_shortcuts([], number_levels), do: add_edge(%{}, number_levels)
   defp precalculate_shortcuts(shortcuts, number_levels) do
     stops = Enum.map(shortcuts, &(&1.initial)) ++ Enum.map(shortcuts, &(&1.final)) |> Enum.uniq
     stops
       |> Enum.sort
       |> Enum.map(fn(level) ->
         available_shortcuts = shortcuts
                                 |> Enum.filter(fn (x) -> available_shortcut(x, level) end)
                                 |> exclude_repeated_finals
                                 |> remove_big_ways level
         {level, %{:list => available_shortcuts, :min => Enum.min_by(available_shortcuts, &(&1.time), fn -> nil end)}}
       end)
       |> Enum.into %{}
       |> add_edge number_levels
   end

   defp add_edge(map_shortcuts, number_levels) do
     min = Enum.min Map.keys(map_shortcuts), fn -> number_levels end
     if (min > 1) do
       amount = Enum.sum 1..(min - 1)
       Map.put map_shortcuts, 1, %{:list => [%{:initial => 1, :final => min, :time => amount}], :min => amount}
     else
       map_shortcuts
     end
   end

   defp available_shortcut(shortcut, level) do
     shortcut.initial <= level && shortcut.final > level
   end

   defp exclude_repeated_finals(shortcuts) do
     grouped_shortcuts = Enum.group_by(shortcuts, fn(x) -> x.final end, fn(x) -> {x.initial, x.time} end)
     Enum.map(grouped_shortcuts, fn({final, values}) ->
       minimal_value = Enum.min_by(values, fn({initial, time}) -> time end)
       %{:initial => elem(minimal_value, 0), :final => final, :time => elem(minimal_value, 1)} end)
   end

   defp remove_big_ways(shortcuts, level) do
     Enum.filter shortcuts, fn(shortcut) ->
       Enum.sum((level)..(shortcut.final - 1)) >= shortcut.time
     end
   end

   defp key_for_shortcut(shortcut) do
     {shortcut.initial, shortcut.final}
   end

end
