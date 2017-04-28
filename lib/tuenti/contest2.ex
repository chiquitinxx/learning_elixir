defmodule Contest2 do
   @moduledoc "Tuenti contest 2"

   def bowling(filename) do
     file = File.read!(filename)
     lines = String.split(file, "\n")
     {number_tests, _} = Enum.at(lines, 0) |> Integer.parse
     play_games(remove_empty_lines(Enum.drop(lines, 1)), 1, number_tests)
   end

   defp remove_empty_lines(list) do
      Enum.filter list, fn(x) -> x != "" end
   end

   defp play_games([rolls, scores | rest], test_number, number_tests) do
     {number_rolls, _} = Integer.parse rolls
     list_scores = Enum.map(String.split(scores, " "), &(Integer.parse(&1) |> elem(0)))
     #sum_maximums = Enum.map(list_maximums, fn(x) -> elem(Integer.parse(x), 0) end) |> Enum.sum
     IO.write "Case #" <> Integer.to_string(test_number) <> ":"
     #<> Integer.to_string(get_number_pizzas(sum_maximums))
     draw_frames_scores(list_scores, 1, 0)
     play_games(rest, test_number + 1, number_tests)
   end

   defp play_games([], test_number, number_tests) when test_number != (number_tests + 1) do
     IO.puts "Executed more tests that expected"
   end

   defp play_games([], test_number, number_tests) do
     IO.puts "\nDone!"
   end

   defp draw_frames_scores(scores, number_frame, total_score) when number_frame > 10 do
     IO.puts ""
   end

   defp draw_frames_scores(scores, number_frame, acc_score) do
     score = acc_score + score_at_frame(scores)
     IO.write " " <> Integer.to_string(score)
     draw_frames_scores(scores_next_frames(scores), number_frame + 1, score)
   end

   defp scores_next_frames([10 | rest]) do
     rest
   end

   defp scores_next_frames([_, _ | rest]) do
     rest
   end

   defp score_at_frame([first, second, third | _]) when first == 10 do
     first + second + third
   end

   defp score_at_frame([first, second, third | _]) when first + second == 10 do
     first + second + third
   end

   defp score_at_frame([first, second | _]) do
     first + second
   end

end
