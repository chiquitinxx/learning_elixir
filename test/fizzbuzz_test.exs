defmodule FizzBuzzTest do
  use ExUnit.Case

  test "fizz buzz first numbers" do
    assert Fizzbuzz.fizzbuzz(-5) == []
    assert Fizzbuzz.fizzbuzz(0) == []
    assert Fizzbuzz.fizzbuzz(2) == [1, 2]
    assert Fizzbuzz.fizzbuzz(6) == [1, 2, "Fizz", 4, "Buzz", "Fizz"]
    assert Fizzbuzz.fizzbuzz(20) == [
      1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz",
      11, "Fizz", 13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"
    ]
  end
end
