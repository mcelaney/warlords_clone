defmodule Warlords.Core.Gameboard.Terrain do
  @moduledoc """
  Types of map tiles affecting movement and combat.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  An atom used to reference a specific terrain, e.g. :hill, :beach, :mountain
  """
  @type terrain_id :: Ecto.Atom

  @typedoc """
  Categories of terrain type providing exclusive access to certain army types

  - **:ground** - ground and air armies can move on this terrain
  - **:sea** - stacks containing sea armies can move on this terrain
  - **:bridge** - a special hybrid of ground and sea any army can move on
  - **:restricted** - only air and rider stacked with air armies can move on this terrain

  It's posible for armies to be abandoned by a stack and left unable to move
  off a tile - say a hero is moved on to mountains by a dragon and left there.
  """
  @type terrain_type :: :ground | :sea | :bridge | :restricted

  @typedoc """
  Defines limitations on movement based on the terrain type.

  - **Ground units** can only move on ground-based terrains unless in a stack with a
  sea unit.

  - **Sea units** can only move on water-based terrains and can carry any rider or
  ground unit on the same.

  - **Air units** can move anywhere and can carry rider. They also provide an attack
  bonus to other armies in the same stack.

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
    field(:type, Ecto.Enum, values: [:ground, :sea, :bridge, :restricted])
  end

  @doc """
  Generates a new terrain from the given attributes

  ## Examples

      iex> Warlords.Core.Gameboard.Terrain.new!(%{
      ...>   id: :hill,
      ...>   type: :ground
      ...> })

      %Warlords.Core.Gameboard.Terrain{id: :hill, type: :ground}
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
      ...>   type: :ground
      ...> })

      {:ok, %Warlords.Core.Gameboard.Terrain{id: :hill, type: :ground}}
  """
  @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_terrain)
  end

  @fields ~w(id type)a
  defp changeset(terrain, attrs) do
    terrain
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
