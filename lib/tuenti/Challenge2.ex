defmodule Tuenti19.Challenge2 do
    @moduledoc "Tuenti 2019 Challenge 2"
    import Integer

    @start "Galactica"
    @destination "New Earth"

    def all_ways(inputFile) do
        file = File.read!(inputFile)
        [first_line | lines] = String.split(file, "\n")
        number_tests = first_line |> Integer.parse |> elem(0)
        IO.puts "Start:"
        process_all_ways(lines, number_tests, 1)
    end

    def number_ways(map, current \\ @start, total \\ 0) do
        destinations = map[current]
        final_destinations = Enum.count(destinations, &(&1 == @destination))
        non_final_destinations = Enum.filter(destinations, &(&1 != @destination))
        final_destinations + total + Enum.sum(
            Enum.map(non_final_destinations, fn destination -> number_ways(map, destination) end)
        ) 
    end

    defp process_all_ways(_rest, number_tests, current) when current > number_tests do
        IO.puts "\nDone!"
      end

    defp process_all_ways([planets | rest], number_tests, current) do
        number_planets = planets |> Integer.parse |> elem(0)
        map = read_map(Enum.take(rest, number_planets))
        IO.puts "Case #" <> Integer.to_string(current) <> ": " <> Integer.to_string(number_ways(map))
        process_all_ways(Enum.drop(rest, number_planets), number_tests, current + 1)
    end

    defp read_map(list_planets) do
        Enum.map_reduce(list_planets, %{}, fn line, acc ->
            {planet, destinations} = extract_line(line)
            { planet, Map.put(acc, planet, destinations) }
        end) |> elem(1)
    end

    defp extract_line(line) do
        [planet, destinations | _rest] = String.split(line, ":")
        {planet, String.split(destinations, ",")}
    end
end