defmodule Ecto.TupleList do
  use Ecto.Type

  @moduledoc """
  Custom Type to support `:atom`

  ## Examples
  ```
  defmodule Post do
    use Ecto.Schema
    schema "posts" do
      field :atom_field, Ecto.TupleList
    end
  end
  ```
  """

  def type, do: {:array, :integer}

  def cast(value) when is_list(value), do: {:ok, value}
  def cast(_), do: :error

  def load(list) do
    {
      :ok,
      list
      |> Enum.chunk_every(2)
      |> Enum.map(fn [left, right] -> {left, right} end)
      |> Enum.reverse()
    }
  end

  def dump(value) when is_list(value) do
    {:ok, Enum.reduce(value, [], fn {left, right}, acc -> [left | [right | acc]] end)}
  end

  def dump(_), do: :error
end
