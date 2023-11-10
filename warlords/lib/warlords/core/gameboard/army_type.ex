defmodule Warlords.Core.Gameboard.ArmyType do
  @moduledoc """
  Defines the types of playable armies which can be found or produced by players.

  These are used, in combination with `Warlords.Core.ArmyTemplate`, to generate
  individual armies.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  An atom used to reference a specific army type, e.g. :archer, :hero, :dragon
  """
  @type army_id :: Ecto.Atom

  @typedoc """
  Defines possible bonuses and indicates how units can be aquired

  There are three types of armys: standard, special, and hero

  - **Standard armies** can be produced in cities and require a per-turn upkeep cost.

  - **Special armies** must be found in ruins or are given as a random bonus with
  heros. They also provide a defense bonus to other armies in the same stack.

  - **Heros** can be hired when offered. They provide an attack bonus other armies in
  the same stack.
  """
  @type army_type :: :standard | :special | :hero

  @typedoc """
  Defines limitations on movement based on the terrain type.

  - **Ground units** can only move on ground-based terrains unless in a stack with a
  sea unit.

  - **Sea units** can only move on water-based terrains and can carry any mimic or
  ground unit on the same.

  - **Air units** can move anywhere and can carry mimics. They also provide an attack
  bonus to other armies in the same stack.

  - **Mimics** move like ground units unless in a stack with an air or sea unit.
  """
  @type terrain_access :: :ground | :air | :sea | :mimic

  @type t :: %__MODULE__{
          id: army_id(),
          label: String.t(),
          type: army_type(),
          access: terrain_access()
        }

  @primary_key false
  embedded_schema do
    field(:id, Ecto.Atom)
    field(:label, :string)
    field(:type, Ecto.Enum, values: [:standard, :special, :hero])
    field(:access, Ecto.Enum, values: [:ground, :air, :sea, :mimic])
  end

  @doc """
  Generates a new army type from the given attributes

  ## Examples

      iex> Warlords.Core.Gameboard.ArmyType.new(%{
      ...>   id: :archer,
      ...>   label: "Elven Archers",
      ...>   type: :standard,
      ...>   access: :ground
      ...> })

      %Warlords.Core.Gameboard.ArmyType{id: :archer, label: "Elven Archers",
                          type: :standard, access: :groud}
  """
  @spec new!(attrs :: map) :: t() | no_return()
  def new!(attrs) do
    with {:ok, army_type} <- new(attrs) do
      army_type
    else
      {:error, changeset} ->
        raise "Failed to create army type: #{inspect(changeset.errors)}"
    end
  end

  @doc """
  Generates a new army type from the given attributes returned as a tagged tuple

  ## Examples

      iex> Warlords.Core.Gameboard.ArmyType.new(%{
      ...>   id: :archer,
      ...>   label: "Elven Archers",
      ...>   type: :standard,
      ...>   access: :ground
      ...> })

      {
        :ok,
        %Warlords.Core.Gameboard.ArmyType{id: :archer, label: "Elven Archers",
                            type: :standard, access: :groud}
      }
  """
  @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_army_type)
  end

  @fields ~w(id label type access)a
  defp changeset(army, attrs) do
    army
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
