defmodule MachineTest do
  use ExUnit.Case

  test "starting genserver discover" do
    {:ok, pid} = Machine.start_link 0
    assert Machine.inc(pid) == 1
    assert Machine.inc(pid) == 2
    assert Machine.dec(pid) == 1
    assert Machine.operations?(pid) == 3
    assert Machine.reset_to(pid, -5) == :ok
    assert Machine.inc(pid) == -4
    assert Machine.operations?(pid) == 5
  end
end
