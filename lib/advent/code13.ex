defmodule Code13 do
    @moduledoc "Advent of code 2018 day 13"

    def read_track(lines) do
        {:ok, String.split(String.normalize(lines, :nfc), "\n")}
    end

    def track_at(track, {x, y}) do
        String.at(Enum.at(track, y), x)    
    end

    def extract_arrows(track) do
        {new_track, all_arrows } = track 
            |> Enum.with_index
            |> Enum.map(&extract_arrows_from_line/1)
            |> Enum.reduce(
                { [], [] },
                fn {string, arrows}, {acc_track, acc_arrows} -> {[string | acc_track], arrows ++ acc_arrows} end
                )
        { Enum.reverse(new_track), Enum.reverse(all_arrows) }
    end

    def move_arrow(%{position: position, direction: direction, turn: turn}, 
                    char_at_arrow) when char_at_arrow == "|" do
        %{position: calculate_new_position(position, direction), direction: direction, turn: turn}
    end

    def move_arrow(%{position: position, direction: direction, turn: turn}, 
                    char_at_arrow) when char_at_arrow == "-" do
        %{position: calculate_new_position(position, direction), direction: direction, turn: turn}
    end    

    def move_arrow(%{position: position, direction: direction, turn: turn}, char_at_arrow) when char_at_arrow == "+" do
        new_direction = calculate_intersection_new_direction(direction, turn)
        %{position: calculate_new_position(position, new_direction), direction: new_direction, turn: next_turn(turn)}
    end    

    def move_arrow(%{position: position, direction: direction, turn: turn}, char_at_arrow) when char_at_arrow == "/" do
        new_direction = case direction do
            :up -> :right
            :down -> :left
            :right -> :up
            :left -> :down
        end
        %{position: calculate_new_position(position, new_direction), direction: new_direction, turn: turn}
    end    

    def move_arrow(%{position: position, direction: direction, turn: turn}, char_at_arrow) when char_at_arrow == "\\" do
        new_direction = case direction do
            :up -> :left
            :down -> :right
            :right -> :down
            :left -> :up
        end
        %{position: calculate_new_position(position, new_direction), direction: new_direction, turn: turn}
    end 

    def move_arrows(arrows, track) do
        sorted_arrows = Enum.sort(arrows, &sort_arrows/2)
        new_arrows = sorted_arrows 
            |> Enum.map(fn arrow -> 
                char = Code13.track_at(track, arrow.position)
                new_arrow = move_arrow(arrow, char)
                case Enum.find(sorted_arrows, fn current_arrow -> current_arrow != arrow && new_arrow.position == current_arrow.position end) do
                    nil -> {:ok, new_arrow}
                    _ -> {:crash, new_arrow.position}
                end
            end)
        first_crash = Enum.find(new_arrows, fn {status, _data} -> status == :crash end)
        case first_crash do
            nil -> {:ok, Enum.map(new_arrows, fn {_status, arrow} -> arrow end) }
            _ -> first_crash
        end
    end

    def find_first_crash(track, arrows) do
        {status, data} = move_arrows(arrows, track)
        case status do
            :ok -> find_first_crash(track, data)
            _ -> data
        end
    end

    defp calculate_new_position({x, y}, direction) do
        case direction do
            :up -> { x, y - 1}
            :down -> { x, y + 1}
            :left -> { x - 1, y}
            :right -> { x + 1, y}
        end
    end  

    defp extract_arrows_from_line({line, index}) do
        arrows = []
        check_for_arrows(String.codepoints(line), 0, index, arrows)    
    end

    defp check_for_arrows(chars, pos, _y, arrows) when length(chars) <= pos  do 
        { List.to_string(chars), arrows }
    end

    defp check_for_arrows(chars, pos, y, arrows) do
        char = Enum.at(chars, pos)
        case Enum.find(["<", ">", "^", "v"], fn x -> x == char end) do
            nil -> check_for_arrows(chars, pos + 1, y, arrows)
            _ -> check_for_arrows(
                Enum.take(chars, pos) ++ [path_from_arrow(char)] ++ Enum.drop(chars, pos + 1), 
                pos + 1,
                y,
                [init_arrow_from_char(char, pos, y) | arrows]
                )
        end
    end

    defp path_from_arrow(char) do
        case char do
            ">" -> "-"
            "<" -> "-"
            "^" -> "|"
            "v" -> "|"
        end
    end

    defp init_arrow_from_char(char, x, y) do
        direction = case char do
            ">" -> :right
            "<" -> :left
            "^" -> :up
            "v" -> :down           
        end
        %{position: {x, y}, direction: direction, turn: :left}
    end

    defp calculate_intersection_new_direction(direction, turn) when turn == :straight do
        direction
    end

    defp calculate_intersection_new_direction(direction, turn) do
        case turn do
            :right -> turn_right(direction)
            :left -> turn_left(direction)
        end
    end

    defp turn_right(direction) do
        case direction do
            :up -> :right
            :down -> :left
            :right -> :down
            :left -> :up
        end
    end

    defp turn_left(direction) do
        case direction do
            :up -> :left
            :down -> :right
            :right -> :up
            :left -> :down
        end
    end

    defp next_turn(turn) do
        case turn do
            :left -> :straight
            :straight -> :right
            :right -> :left
        end
    end

    def sort_arrows(first_arrow, second_arrow) do
        {x1, y1} = first_arrow.position
        {x2, y2} = second_arrow.position
        cond do
            y1 == y2 -> x1 < x2
            y1 > y2 -> false
            y2 < y1 -> true
            true -> true
        end
    end
end