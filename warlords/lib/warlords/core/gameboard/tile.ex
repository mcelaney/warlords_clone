defmodule Warlords.Core.Gameboard.Tile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Warlords.Core.Gameboard.Terrain
  alias Warlords.Core.Units.Stack

  @typedoc """
  The placement of a tile on the gameboard

  "X" is the horizontal axis, "Y" is the vertical axis. The origin is at {1,1}
  """
  @type position :: {x :: integer, y :: integer}

  @typedoc """
  The position as a string, e.g. "1,1", "12,120"
  """
  @type position_label :: String.t()

  @typedoc """
  A list of tiles intended to act as one location, e.g. a city

  This is a list of positions, e.g. [{1,1}, {1,2}, {2,1}, {2,2}] and the list
  should be inclusive of the current tile.
  """
  @type connected_tiles :: [{x :: integer, y :: integer}]

  @type t :: %__MODULE__{
          x: integer(),
          y: integer(),
          terrain: Terrain.t(),
          stack: Stack.t(),
          connected: connected_tiles()
        }

  @primary_key false
  embedded_schema do
    field(:x, :integer)
    field(:y, :integer)
    field(:connected, Ecto.TupleList)

    embeds_one(:terrain, Terrain)
    embeds_one(:stack, Stack, on_replace: :delete)
  end

  @doc """
  Adds a stack to the tile

  ## Examples

      iex> Warlords.Core.Gameboard.Tile.new!(%{
      ...>   x: 50,
      ...>   y: 100,
      ...>   terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land}
      ...> })
      ...> |> Warlords.Core.Gameboard.Tile.add_stack(%Warlords.Core.Units.Stack{})

      %Warlords.Core.Gameboard.tile{x: 50, y: 100, terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land},
                                   stack: %Warlords.Core.Units.Stack{}}

      iex> Warlords.Core.Gameboard.Tile.new!(%{
      ...>   x: 50,
      ...>   y: 100,
      ...>   terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land},
      ...>   stack: %Warlords.Core.Units.Stack{label: "Gildenhome 1st Elven Archers"}
      ...> })
      ...> |> Warlords.Core.Gameboard.Tile.add_stack(%Warlords.Core.Units.Stack{label: "Gildenhome 2nd Elven Archers"})

      %Warlords.Core.Gameboard.tile{x: 50, y: 100, terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land},
                                   stack: %Warlords.Core.Units.Stack{label: "Gildenhome 1st Elven Archers"}, %Warlords.Core.Units.Stack{label: "Gildenhome 2nd Elven Archers"}}
  """
  def add_stack(
        %{stack: %{units: [_ | _], empire_id: empire_id} = left} = tile,
        %{empire_id: empire_id} = right
      ) do
    with {:ok, stack} <- Stack.merge(left, right) do
      tile
      |> change()
      |> put_embed(:stack, stack)
      |> Ecto.Changeset.apply_action(:update)
    end
  end

  def add_stack(%{stack: %{units: [_ | _]}} = _tile, _right) do
    {:error, "Stack belongs to another player"}
  end

  def add_stack(tile, stack) do
    tile
    |> change()
    |> put_embed(:stack, stack)
    |> Ecto.Changeset.apply_action(:update)
  end

  @doc """
  Generates a new gameboard tile from the given attributes

  ## Examples

      iex> Warlords.Core.Gameboard.Tile.new!(%{
      ...>   x: 50,
      ...>   y: 100,
      ...>   terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land}
      ...> })

      %Warlords.Core.Gameboard.tile{x: 50, y: 100, terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land}}

      iex> Warlords.Core.Gameboard.Tile.new!(%{
      ...>   x: 50,
      ...>   y: 100,
      ...>   terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land},
      ...>   connected: [{50, 100}, {50, 101}, {51, 100}, {51, 101}]
      ...> })

      %Warlords.Core.Gameboard.tile{x: 50, y: 100, terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land},
                                   connected: [{50, 100}, {50, 101}, {51, 100}, {51, 101}]}
  """
  def new!(attrs) do
    with {:ok, tile} <- new(attrs) do
      tile
    else
      {:error, changeset} ->
        raise "Failed to create tile: #{inspect(changeset.errors)}"
    end
  end

  @doc """
  Generates a new gameboard tile from the given attributes

  ## Examples

      iex> Warlords.Core.Gameboard.Tile.new!(%{
      ...>   x: 50,
      ...>   y: 100,
      ...>   terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land}
      ...> })

      {
        :ok,
        %Warlords.Core.Gameboard.tile{x: 50, y: 100,
        terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land}}
      }

      iex> Warlords.Core.Gameboard.Tile.new!(%{
      ...>   x: 50,
      ...>   y: 100,
      ...>   terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :ground},
      ...>   connected: [{50, 100}, {50, 101}, {51, 100}, {51, 101}]
      ...> })

      {
        :ok,
        %Warlords.Core.Gameboard.tile{x: 50, y: 100,
        terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :ground}},
        ...>   connected: [{50, 100}, {50, 101}, {51, 100}, {51, 101}]
      }
  """
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_tile)
  end

  @fields ~w(x y connected)a
  def changeset(tile, attrs) do
    tile
    |> cast(attrs, @fields)
    |> validate_number(:x, greater_than_or_equal_to: 0)
    |> validate_number(:y, greater_than_or_equal_to: 0)
    |> put_embed(:terrain, attrs[:terrain] || attrs["terrain"])
    |> validate_required([:x, :y, :terrain])
  end
end
