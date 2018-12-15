defmodule Code13b do
    @moduledoc "Advent of code 2018 day 13 part b"

    def find_last_up(track, arrows, number \\ 0) do
        {new_arrows, {to_delete, moved}} = move_arrows_and_mark_crasheds(arrows, track)
        filtered_arrows = new_arrows
            |> Enum.with_index 
            |> Enum.filter(fn {_arrow, index} -> Enum.find(to_delete, &(&1 == index)) == nil end)
            |> Enum.map(&(elem(&1, 0)))
        #IO.inspect(number, label: "Number of steps: ")
        case Enum.count(filtered_arrows) do
            1 -> Enum.at(filtered_arrows, 0)
            0 -> throw(:all_crashed)  # ????? can happen?
            _ -> find_last_up(track, filtered_arrows, number + 1)
        end
    end

    defp move_arrows_and_mark_crasheds(arrows, track) do
        sorted_arrows_with_index = Enum.with_index(Enum.sort(arrows, &Code13.sort_arrows/2))
        sorted_arrows_with_index
            |> Enum.map_reduce({[], []}, fn {arrow, index}, {to_delete, moved} -> 
                case Enum.find(to_delete, &(&1 == index)) do
                    nil -> move_and_to_delete_if_crashes(track, arrow, index, sorted_arrows_with_index, to_delete, moved)
                    _ -> { arrow, { to_delete, moved } }
                end
            end)
    end

    defp move_and_to_delete_if_crashes(track, arrow, index, sorted_arrows_with_index, to_delete, moved) do
        
        new_arrow = Code13.move_arrow(arrow, Code13.track_at(track, arrow.position))

        find_previous_crashed = Enum.find(moved, fn {idx, moved_arrow} -> 
            moved_arrow.position == new_arrow.position && Enum.find(to_delete, &(&1 == idx)) == nil
        end)
        case find_previous_crashed do
            nil -> find_next_crash(new_arrow, index, sorted_arrows_with_index, to_delete, moved)
            { idx, moved_arrow } -> { arrow, { [ idx, index | to_delete ], moved } }
        end     
    end

    defp find_next_crash(new_arrow, index, sorted_arrows_with_index, to_delete, moved) do
        find_next_crashed = Enum.find_index(sorted_arrows_with_index, 
            fn {c_arrow, sorted_index} -> 
                sorted_index > index &&
                Enum.find(to_delete, &(&1 == sorted_index)) == nil &&
                c_arrow.position == new_arrow.position
            end)

        case find_next_crashed do
            nil -> { new_arrow, {to_delete, [ {index, new_arrow } | moved ] } }
            _ -> { new_arrow, { [ find_next_crashed, index | to_delete ], moved } }
        end         
    end
end
