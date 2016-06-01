defmodule AgentsTest do
  use ExUnit.Case

  test "init agent" do
    agent = Agents.init fn -> 0 end
    assert Agents.get(agent) == 0
    assert Agents.get(agent) == 0
  end

end
