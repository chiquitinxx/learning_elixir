defmodule Tuenti19.Challenge2Test do
  use ExUnit.Case
  import Tuenti19.Challenge2

  @one_step %{"Galactica" => ["New Earth"]}
  @sample %{
    "Galactica" => ["A","B","C"],
    "A" => ["E","D"],
    "B" => ["D"],
    "C" => ["D","F"],
    "D" => ["F"],
    "E" => ["New Earth"],
    "F" => ["New Earth"]
  }
  @other %{
    "Galactica" => ["A","New Earth"],
    "A" => ["B"],
    "B" => ["New Earth"]
  }

  test "number ways" do
    assert number_ways(@one_step) == 1
    assert number_ways(@other) == 2
    assert number_ways(@sample) == 5
  end

  test "galactica" do
    #all_ways("test/input/submitInput2")
  end

end
