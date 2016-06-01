defmodule Agents do
  @moduledoc "Trying agents"
  def init(fun) do
    {:ok, agent} = Agent.start fun
    agent
  end

  def get(agent) do
    Agent.get(agent, &(&1))
  end
end
