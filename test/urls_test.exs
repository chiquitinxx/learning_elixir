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
    prefix = "http://localhost/"
    assert Urls.short("http://www.google.com", prefix) == "http://localhost/gtu"
    assert Urls.short("http://tecnologia.elpais.com/tecnologia/2015/12/04/actualidad/1449259283_679909.html", prefix) == "http://localhost/egia"
  end
end