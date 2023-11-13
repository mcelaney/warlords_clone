defmodule Warlords.Core.Gameboard.Terrain do
  @moduledoc """
  Types of map tiles affecting movement and combat.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Warlords.Core.Units.Stack
  alias Warlords.Core.Gameboard.Empire
  alias Warlords.Core.Gameboard.Tile

  @typedoc """
  An atom used to reference a specific terrain, e.g. :hill, :beach, :mountain
  """
  @type terrain_id :: Ecto.Atom

  @typedoc """
  Categories of terrain type providing exclusive access to certain army types

  - **:land** - land and air armies can move on this terrain
  - **:sea** - stacks containing sea armies can move on this terrain
  - **:bridge** - a special hybrid of land and sea any army can move on
  - **:restricted** - only air and rider stacked with air armies can move on this terrain

  It's posible for armies to be abandoned by a stack and left unable to move
  off a tile - say a hero is moved on to mountains by a dragon and left there.
  """
  @type terrain_type :: :land | :sea | :city | :bridge | :restricted

  @typedoc """
  Defines limitations on movement based on the terrain type.

  - **ground units** can only move on land-based terrains unless in a stack with a
  sea unit.

  - **Sea units** can only move on water-based terrains and can carry any rider or
  land unit on the same.

  - **Air units** can move anywhere and can carry rider. They also provide an attack
  bonus to other armies in the same stack. Can not access restricted terrains if
  stacked with ground units

  - **Rider** move like ground units unless in a stack with an air or sea unit.
  """
  @type access_type :: :ground | :air | :sea | :rider

  @type t :: %__MODULE__{
          id: terrain_id(),
          type: terrain_type()
        }

  @primary_key false
  embedded_schema do
    field(:id, Ecto.Atom)
    field(:type, Ecto.Enum, values: [:land, :sea, :city, :bridge, :restricted])
    field(:combat_modifiers, :map)
  end

  @doc """
  Returns the terrain combat modifier for the defender of a given tile

  Empires can have a combat modifier (positive or negative) based on terrain
  type. Members of the elvish empire (regardless of the army_type) will perform
  better in forests and perform worse in marshland, for example.

  ## Examples

      iex> tile = %Warlords.Core.Gameboard.Tile{terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land, combat_modifiers: %{elvallie: 1}}, stack: %Warlords.Core.Units.Stack{empire_id: :elvallie}}
      ...> Warlords.Core.Gameboard.Terrain.combat_modifier(tile)
      1
  """
  @spec combat_modifier(Tile.t()) :: integer
  def combat_modifier(%Tile{stack: %Stack{empire_id: empire_id}, terrain: terrain}) do
    terrain.combat_modifiers[empire_id]
  end

  def combat_modifier(%Tile{}), do: 0

  @doc """
  Returns the terrain combat modifier for an empire

  Empires can have a combat modifier (positive or negative) based on terrain
  type. Members of the elvish empire (regardless of the army_type) will perform
  better in forests and perform worse in marshland, for example.

  ## Examples

      iex> tile = %Warlords.Core.Gameboard.Tile{terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land, combat_modifiers: %{elvallie: 2}}}
      ...> Warlords.Core.Gameboard.Terrain.combat_modifier(tile, %Warlords.Core.Units.Stack{empire_id: :elvallie})
      2

      iex> tile = %Warlords.Core.Gameboard.Tile{terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land, combat_modifiers: %{elvallie: 3}}}
      ...> Warlords.Core.Gameboard.Terrain.combat_modifier(tile, :elvallie)
      3

      iex> terrain = %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land, combat_modifiers: %{elvallie: 2}}
      ...> Warlords.Core.Gameboard.Terrain.combat_modifier(terrain, %Warlords.Core.Units.Stack{empire_id: :elvallie})
      2

      iex> terrain = %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land, combat_modifiers: %{elvallie: 3}}
      ...> Warlords.Core.Gameboard.Terrain.combat_modifier(terrain, :elvallie)
      3
  """
  @spec combat_modifier(Tile.t() | t, Empire.empire_id() | Stack.t()) :: integer
  def combat_modifier(%Tile{terrain: terrain}, empire_id) when is_atom(empire_id) do
    terrain.combat_modifiers[empire_id]
  end

  def combat_modifier(%Tile{terrain: terrain}, %Stack{empire_id: empire_id}) do
    terrain.combat_modifiers[empire_id]
  end

  def combat_modifier(%__MODULE__{} = terrain, empire_id) when is_atom(empire_id) do
    terrain.combat_modifiers[empire_id]
  end

  def combat_modifier(%__MODULE__{} = terrain, %Stack{empire_id: empire_id}) do
    terrain.combat_modifiers[empire_id]
  end

  @doc """
  Generates a new terrain from the given attributes

  ## Examples

      iex> Warlords.Core.Gameboard.Terrain.new!(%{
      ...>   id: :hill,
      ...>   type: :land,
      ...>   combat_modifiers: %{elvallie: 0}
      ...> })

      %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land}
  """
  @spec new!(attrs :: map) :: t() | no_return()
  def new!(attrs) do
    with {:ok, terrain} <- new(attrs) do
      terrain
    else
      {:error, changeset} ->
        raise "Failed to create terrain: #{inspect(changeset.errors)}"
    end
  end

  @doc """
  Generates a new terrain from the given attributes returned as a tagged tuple

  ## Examples

      iex> Warlords.Core.Gameboard.Terrain.new(%{
      ...>   id: :hill,
      ...>   type: :land,
      ...>   combat_modifiers: %{elvallie: 0}
      ...> })

      {:ok, %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land}}
  """
  @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_terrain)
  end

  @fields ~w(id type combat_modifiers)a
  defp changeset(terrain, attrs) do
    terrain
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
