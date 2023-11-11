defmodule Warlords.Core.Hero do
  @moduledoc """
  Leaders on the gameboard

  Heros offer themselves for hire at semi-random intervals. They have no upkeep
  cost. Only heros can search ruins and pick up items. They apply a strength
  modifier to all other armies in their stack.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Warlords.Core
  alias Warlords.Core.City.Army.Label
  alias Warlords.Core.Gameboard.ArmyType
  alias Warlords.Core.Gameboard.Item

  @type t :: %__MODULE__{
          label: Label.t(),
          movement: movement_limit(),
          strength: attack_strength(),
          army_type: ArmyType.army_id(),
          terrain_access: ArmyType.terrain_access(),
          upkeep: Core.gold(),
          blessings: [Core.blessing()],
          items: [Item.t()]
        }

  @typedoc """
  The base strength before force combat modifiers are applied
  """
  @type attack_strength :: integer

  @typedoc """
  The number of movement points a units gets per turn. Various unit types
  will have different movement costs for different terrain types
  """
  @type movement_limit :: integer

  @primary_key false
  embedded_schema do
    field(:label, :string)
    field(:strength, :integer)
    field(:movement, :integer)
    field(:army_type, Ecto.Atom)
    field(:terrain_access, Ecto.Atom, default: :mimic)
    field(:upkeep, :integer, default: 0)
    field(:blessings, {:array, :string}, default: [])

    embeds_many(:items, Item)
  end

  @doc """
  Generates a new army type from the given attributes

  ## Examples

      iex> Warlords.Core.Hero.new!(%{
      ...>   label: "Brave Sir Robin",
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   army_type: :hero,
      ...> })

      %Warlords.Core.City.Army{label: "Brave Sir Robin",
                              strength: 4, movement: 12, upkeep: 0,
                              army_type :hero, terrain_access: :mimic,
                              blessings: []}
  """
  @spec new!(attrs :: map) :: t() | no_return()
  def new!(attrs) do
    with {:ok, hero} <- new(attrs) do
      hero
    else
      {:error, changeset} ->
        raise "Failed to create hero: #{inspect(changeset.errors)}"
    end
  end

  @doc """
  Generates a new army type from the given attributes returned as a tagged tuple

  ## Examples

      iex> Warlords.Core.City.Army.new(%{
      ...>   label: "Brave Sir Robin",
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   army_type: :hero,
      ...> })

      {
        :ok,
        %Warlords.Core.City.Army{label: "Brave Sir Robin",
                                strength: 4, movement: 12, upkeep: 0,
                                army_type :hero, terrain_access: :mimic,
                                blessings: []}
      }
  """
  @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_army)
  end

  @fields ~w(label strength movement army_type)a
  defp changeset(army, attrs) do
    army
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
