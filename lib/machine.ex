defmodule Machine do
  use GenServer

  def start_link(default) do
    GenServer.start_link(__MODULE__, {default, 0})
  end

  def inc(pid) do
    GenServer.call pid, :inc
  end

  def dec(pid) do
    GenServer.call pid, :dec
  end

  def operations?(pid) do
    GenServer.call pid, :number_op
  end

  def reset_to(pid, value) do
    GenServer.cast pid, {:set, value}
  end

  # callbacks

  def handle_call(:inc, _from, {number, operations}) do
    new_value = number + 1
    {:reply, new_value, {new_value, operations + 1}}
  end

  def handle_call(:dec, _from, {number, operations}) do
    new_value = number - 1
    {:reply, new_value, {new_value, operations + 1}}
  end

  def handle_call(:number_op, _from, {_, operations} = tuple) do
    {:reply, operations, tuple}
  end

  def handle_cast({:set, value}, {number, operations}) do
    {:noreply, {value, operations + 1}}
  end

end
