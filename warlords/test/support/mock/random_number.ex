defmodule Warlords.Mock.RandomNumber do
  use GenServer

  def init(numbers), do: {:ok, numbers}

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def is_empty do
    GenServer.call(__MODULE__, :is_empty)
  end

  def stop do
    GenServer.cast(__MODULE__, :stop)
  end

  def start_link(numbers) do
    GenServer.start_link(__MODULE__, numbers, name: __MODULE__)
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(:is_empty, _from, state) do
    {:reply, Enum.count(state) == 0, state}
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end
end
