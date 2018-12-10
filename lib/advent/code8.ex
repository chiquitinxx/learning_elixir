defmodule Code8 do
    @moduledoc "Advent of code 2018 day 8"

    def sum_metadata(text) do
        tree_list = text 
            |> String.split(" ")
            |> Enum.map(&String.to_integer/1)
        {_list, acc} = node(tree_list, 0)
        acc
    end

    defp node([], acc) do
        { [], acc }
    end

    defp node([number_child_nodes, number_metadata | rest ], acc) do
        {list, acc} = process_childs(number_child_nodes, rest, acc)
        amount_metadata = Enum.sum(Enum.take(list, number_metadata))
        {Enum.drop(list, number_metadata), amount_metadata + acc}
    end

    defp process_childs(0, rest, acc) do
        { rest, acc }
    end

    defp process_childs(number_childs, rest, acc) do
        { rest, acc } = node(rest, acc)
        process_childs(number_childs - 1, rest, acc)
    end
end