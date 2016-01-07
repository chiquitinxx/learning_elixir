defmodule HttpoisonTest do
  use ExUnit.Case

  test "do a remote call" do
    HTTPoison.start
    headers = [{"User-agent", "My agent"}]
    {result, response} = HTTPoison.get(
      "https://api.github.com/repos/chiquitinxx/grooscript/issues", headers)
    assert result == :ok
  end
end