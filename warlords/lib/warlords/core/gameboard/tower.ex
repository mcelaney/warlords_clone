defmodule Warlords.Core.Gameboard.Tower do
  @moduledoc """
  Towers are special buildings which can be built by players. They provide
  a defensive bonus to the tile they are built on. They can not be upgraded.
  """
  use Ecto.Schema
  alias Warlords.Core

  @type t :: %__MODULE__{
          defense: Core.strength_points()
        }

  @primary_key false
  embedded_schema do
    field(:defense, :integer)
  end

  @doc """
  Generates a new tower as a tagged tuple

  ## Examples

      iex> Warlords.Core.Gameboard.Tower.new()
      {:ok, %Warlords.Core.Gameboard.Tower{defense: 1}}
  """
  def new(_), do: new()
  def new, do: {:ok, new!()}

  @doc """
  Generates a new tower

  ## Examples

      iex> Warlords.Core.Gameboard.Tower.new!()
      %Warlords.Core.Gameboard.Tower{defense: 1}
  """
  def new!(_), do: new!()
  def new!, do: %__MODULE__{defense: 1}
end
