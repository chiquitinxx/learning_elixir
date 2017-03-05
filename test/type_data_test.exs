defmodule TypeDataTest do

  use ExUnit.Case

  test "list stuff" do
    assert [1] == [1]
    a = ["hola"]
    assert [1] ++ a == [1, "hola"]
    assert [1] ++ "hola" == [1 | "hola"]
    [h | t] = [1, 5, 9]
    assert hd([1, 5, 9]) == h
    assert tl([1, 5, 9]) == t
    assert h == 1
    assert t == [5, 9]
    assert length(t) == 2
    assert length([]) == 0
  end

  test "tuples" do
    a = {1, "hello", 4.34}
    assert elem(a, 2) == 4.34
    {first, _, _} = a
    assert first == 1
  end

  test "keyword lists" do
    kl = [first: 1, second: 2, third: "three", fourth: :four]
    assert length(kl) == 4
    [h | t] = kl
    assert h == {:first, 1}
    assert t[:fourth] == :four
    assert Keyword.get(kl, :third, :ko) == "three"
    assert Keyword.get(kl, :noexists, :ko) == :ko
  end

  test "maps" do
    map = %{:a => 1, 2 => :b}
    assert map[:a] == 1
    assert map.a == 1
    assert Map.get(map, :a) == 1
  end

  test "structures" do
    users = %{"john" => %{age: 27}, :meg => %{age: 23}}
    updated_users = put_in users["john"].age, 31
    assert users != updated_users
    assert users.meg.age == 23
    assert users["john"].age == 27
    assert updated_users["john"].age == 31
  end

end