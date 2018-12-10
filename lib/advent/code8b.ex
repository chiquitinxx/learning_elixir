defmodule Code8b do
    @moduledoc "Advent of code 2018 day 8 part b"

    def value_root_node(text) do
        elem(value_node(Code8.split_text(text)), 0)
    end

    defp value_node([0, number_metadata | rest ]) do
        { Enum.sum(Enum.take(rest, number_metadata)), Enum.drop(rest, number_metadata) }
    end

    defp value_node([childs, metadata | rest]) do
        {values, rest} = values_childs(childs, rest, [])
        metadata_list = Enum.take(rest, metadata)
        value = metadata_list |> Enum.map(fn (index) -> value_for_pseudo_index(values, index) end) |> Enum.sum
        {value, Enum.drop(rest, metadata) }
    end

    defp value_for_pseudo_index(list, index) do
        value = Enum.at(list, index - 1)
        case value do
            nil -> 0
            _ -> value
        end
    end

    defp values_childs(0, rest, list_values) do
        {Enum.reverse(list_values), rest}
    end

    defp values_childs(number_childs, rest, list_values) do
        { value, rest } = value_node(rest)
        values_childs(number_childs - 1, rest, [value | list_values])
    end
end
