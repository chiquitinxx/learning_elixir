defmodule UrlsTest do
  use ExUnit.Case

  test "reduce to a number" do
    assert Urls.reduce("a") == 97
    assert Urls.reduce("z") == 122
    assert Urls.reduce("hola") == 6284
    assert Urls.reduce("http://www.google.com") == 201984
    assert Urls.reduce("http://tecnologia.elpais.com/tecnologia/2015/12/04/actualidad/1449259283_679909.html") == 2660324
  end

  test "number to small word" do
	  assert Urls.compose(0) == "a"
    assert Urls.compose(1) == "b"
	  assert Urls.compose(25) == "z"
	  assert Urls.compose(26) == "a"
	  assert Urls.compose(245) == "fy"
	  assert Urls.compose(2660324) == "egia"
	  assert Urls.compose(742353475684) == "gevbxw"
  end

  test "short url" do
    assert "gtu" = Urls.short_url("http://www.google.com")
    assert "egia" == Urls.short_url("http://tecnologia.elpais.com/tecnologia/2015/12/04/actualidad/1449259283_679909.html")
  end

  test "random char" do
    letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
      "m" ,"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    created_chars = for _ <- 1..250, do: Urls.random_char
    assert Enum.all? created_chars, &(Enum.member?(letters, &1))
  end

  test "similar short url" do
    short = "shy"
    similar = Urls.similar_short_url short
    assert String.length(similar) == (String.length(short) + 1)
    assert String.starts_with? similar, short
  end
end
