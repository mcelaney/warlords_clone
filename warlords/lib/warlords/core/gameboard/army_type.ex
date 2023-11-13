defmodule Warlords.Core.Gameboard.ArmyType do
  @moduledoc """
  Defines the types of playable armies which can be found or produced by players.

  These are used, in combination with `Warlords.Core.ProductionTemplate`, to generate
  individual armies.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Warlords.Core.Gameboard.Terrain

  @typedoc """
  An atom used to reference a specific army type, e.g. :archer, :hero, :dragon
  """
  @type army_type :: Ecto.Atom

  @typedoc """
  Primarily defines how units can be aquired.

  There are three types of armys: standard, special, and hero

  - **Standard armies** can be produced in cities and require a per-turn upkeep cost.

  - **Special armies** must be found in ruins or are given as a random bonus with
  heros. They also provide a defense bonus to other armies in the same stack.

  - **Heros** can be hired when offered. They provide an attack bonus other armies in
  the same stack.
  """
  @type unit_type :: :standard | :special | :hero

  @type t :: %__MODULE__{
          id: army_type(),
          label: String.t(),
          type: unit_type(),
          access: Terrain.access_type()
        }

  @primary_key false
  embedded_schema do
    field(:id, Ecto.Atom)
    field(:label, :string)
    field(:type, Ecto.Enum, values: [:standard, :special, :hero])
    field(:access, Ecto.Enum, values: [:ground, :air, :sea, :rider])
  end

  @doc """
  Generates a new army type from the given attributes

  ## Examples

      iex> Warlords.Core.Gameboard.ArmyType.new!(%{
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
