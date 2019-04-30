defmodule Tuenti19.Challenge1 do
    @moduledoc "Tuenti 2019 Challenge 1"
    import Integer

    def number_tortillas(inputFile) do
        file = File.read!(inputFile)
        [_first_line | lines] = String.split(file, "\n")
        #{number_tests, _} = first_line |> Integer.parse
        IO.puts ""
        row_number_tortillas(remove_empty_lines(lines), 1)
    end

    defp remove_empty_lines(list) do
        Enum.filter list, fn(x) -> x != "" end
    end

    defp row_number_tortillas([], row) do
        IO.puts "\nDone!"
      end

    defp row_number_tortillas([current | rest], row) do
        #IO.puts current
        IO.puts "Case #" <> Integer.to_string(row) <> ": " <> Integer.to_string(calculate_total(String.split(current, " ")))
        row_number_tortillas(rest, row + 1)
    end

    defp calculate_total([first, second | _rest]) do
        {number1, _} = first |> Integer.parse
        {number2, _} = second |> Integer.parse
        number_complete(number1) + number_complete(number2)
    end

    defp number_complete(number) do
        case is_even(number) do
            true -> Integer.floor_div(number, 2)
            false -> Integer.floor_div(number, 2) + 1
        end       
    end

end