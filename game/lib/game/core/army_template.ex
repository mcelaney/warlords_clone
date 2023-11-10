defmodule Game.Core.ArmyTemplate do
  @moduledoc """
  Provides information needed for city production of new standard armies.

  The stats for a given army is dependent on the city where it was produced.
  These templates ensure the basic information to needed generate armies is
  available.
  """
  use Ecto.Schema
  import Ecto.Changeset
  require Integer
  alias Game.Core.ArmyType

  @type t :: %__MODULE__{
          type: ArmyType.army_id(),
          cost: army_cost(),
          movement: movement_limit(),
          strength: attack_strength(),
          time: turns()
        }

  @typedoc """
  The number of turns it takes to produce an army
  """
  @type turns :: integer

  @typedoc """
  The cost in gold to produce a unit.

  This should always be an even number - and is double the per-turn upkeep cost
  for the unit
  """
  @type army_cost :: integer

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
    field(:type, Ecto.Atom)
    field(:time, :integer)
    field(:cost, :integer)
    field(:strength, :integer)
    field(:movement, :integer)
  end

  @doc """
  Create a new army template from the given attributes

  ## Examples

      iex> Game.Core.ArmyTemplate.new!(%{
      ...>   type: :archers,
      ...>   time: 3,
      ...>   cost: 4,
      ...>   strength: 4,
      ...>   movement: 12
      ...> })

      %Game.Core.ArmyTemplate{type: :archers, time: 3, cost: 4, strength: 4, movement: 12}

  """
  @spec new!(attrs :: map) :: t() | no_return()
  def new!(attrs) do
    with {:ok, army_template} <- new(attrs) do
      army_template
    else
      {:error, changeset} ->
        raise "Failed to create army template: #{inspect(changeset.errors)}"
    end
  end

  @doc """
  Create a new army template from the given attributes returned as a tagged tuple

  ## Examples

      iex> Game.Core.ArmyTemplate.new(%{
      ...>   type: :archers,
      ...>   time: 3,
      ...>   cost: 4,
      ...>   strength: 4,
      ...>   movement: 12
      ...> })

      {:ok, %Game.Core.ArmyTemplate{type: :archers, time: 3, cost: 4, strength: 4, movement: 12}}

  """
  @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_army_template)
  end

  @fields ~w(type time cost strength movement)a
  defp changeset(army_template, attrs) do
    army_template
    |> cast(attrs, @fields)
    |> validate_is_even_number(:cost)
    |> validate_required(@fields)
  end

  defp validate_is_even_number(changeset, field) do
    validate_change(changeset, field, fn field, value ->
      case Integer.is_even(value) do
        true -> []
        false -> [{field, "must be an even number"}]
      end
    end)
  end
end
