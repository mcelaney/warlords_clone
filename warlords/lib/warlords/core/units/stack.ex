defmodule Warlords.Core.Units.Stack do
  @moduledoc """
  A stack of units on the gameboard
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Warlords.Core.Gameboard.Empire
  alias Warlords.Core.Units.Hero
  alias Warlords.Core.Units.Special
  alias Warlords.Core.Units.Stack.CombatModifier
  alias Warlords.Core.Units.Standard

  @type t :: %__MODULE__{
          empire_id: Empire.empire_id(),
          units: [Hero.t() | Special.t() | Standard.t()]
        }

  @max_stack_size 8

  @primary_key false
  embedded_schema do
    field(:empire_id, Ecto.Atom)
    field(:units, {:array, :map})
  end

  defdelegate combat_modifier(stack), to: CombatModifier

  @doc """
  Merge two stacks together

  If the number of units after the merge would be more than the maximum stack
  size it returns an error

  ## Examples

      iex> left_stack = %Warlords.Core.Units.Stack{units: [%Warlords.Core.Units.Standard{label: "Gildenhome 1st Elven Archers"}]}
      ...> right_stack = %Warlords.Core.Units.Stack{units: [%Warlords.Core.Units.Standard{label: "Gildenhome 2nd Elven Archers"}]}
      ...> Warlords.Core.Units.Stack.merge(left_stack, right_stack)

      {:ok, %Warlords.Core.Units.Stack{units: [
        %Warlords.Core.Units.Standard{label: "Gildenhome 1st Elven Archers"},
        %Warlords.Core.Units.Standard{label: "Gildenhome 2nd Elven Archers"}
      ]}}
  """
  @spec merge(t(), t()) :: {:ok, t()} | {:error, String.t()}
  def merge(%{empire_id: empire_id, units: left}, %{empire_id: empire_id, units: right}) do
    case Enum.count(left) + Enum.count(right) < @max_stack_size do
      true -> Warlords.Core.Units.Stack.new(%{units: left ++ right})
      false -> {:error, "Stack can only have up to 8 units"}
    end
  end

  @doc """
  Create a new army template from the given attributes

  ## Examples

      iex> Warlords.Core.Units.Stack.new!(%{empire_id: :storm_giants, units: [
      ...>   %Warlords.Core.Units.Hero{label: "Brave Sir Robin", strength: 5, movement: 12, upkeep: 0, army_type: :hero, terrain_access: :rider, blessings: []},
      ...>   %Warlords.Core.Units.Special{label: "Undead", strength: 6, movement: 10, upkeep: 0, army_type: :ghost, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Special{label: "Dragons", strength: 7, movement: 16, upkeep: 0, army_type: :dragon, terrain_access: :air, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 1st Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 2nd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 3rd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 4th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 5th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []}
      ...> ]})

      %Warlords.Core.Units.Stack{empire_id: :storm_giants, units: [
        %Warlords.Core.Units.Hero{label: "Brave Sir Robin", strength: 5, movement: 12, upkeep: 0, army_type: :hero, terrain_access: :rider, blessings: []},
        %Warlords.Core.Units.Special{label: "Undead", strength: 6, movement: 10, upkeep: 0, army_type: :ghost, terrain_access: :ground, blessings: []},
        %Warlords.Core.Units.Special{label: "Dragons", strength: 7, movement: 16, upkeep: 0, army_type: :dragon, terrain_access: :air, blessings: []},
        %Warlords.Core.Units.Standard{label: "Gildenhome 1st Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []},
        %Warlords.Core.Units.Standard{label: "Gildenhome 2nd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []},
        %Warlords.Core.Units.Standard{label: "Gildenhome 3rd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []},
        %Warlords.Core.Units.Standard{label: "Gildenhome 4th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []},
        %Warlords.Core.Units.Standard{label: "Gildenhome 5th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []}
      ]}

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

      iex> Warlords.Core.Units.Stack.new!(%{empire_id: :storm_giants, units: [
      ...>   %Warlords.Core.Units.Hero{label: "Brave Sir Robin", strength: 5, movement: 12, upkeep: 0, army_type: :hero, terrain_access: :rider, blessings: []},
      ...>   %Warlords.Core.Units.Special{label: "Undead", strength: 6, movement: 10, upkeep: 0, army_type: :ghost, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Special{label: "Dragons", strength: 7, movement: 16, upkeep: 0, army_type: :dragon, terrain_access: :air, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 1st Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 2nd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 3rd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 4th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 5th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []}
      ...> ]})

      {
        :ok,
        %Warlords.Core.Units.Stack{empire_id: :storm_giants, units: [
          %Warlords.Core.Units.Hero{label: "Brave Sir Robin", strength: 5, movement: 12, upkeep: 0, army_type: :hero, terrain_access: :rider, blessings: []},
          %Warlords.Core.Units.Special{label: "Undead", strength: 6, movement: 10, upkeep: 0, army_type: :ghost, terrain_access: :ground, blessings: []},
          %Warlords.Core.Units.Special{label: "Dragons", strength: 7, movement: 16, upkeep: 0, army_type: :dragon, terrain_access: :air, blessings: []},
          %Warlords.Core.Units.Standard{label: "Gildenhome 1st Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []},
          %Warlords.Core.Units.Standard{label: "Gildenhome 2nd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []},
          %Warlords.Core.Units.Standard{label: "Gildenhome 3rd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []},
          %Warlords.Core.Units.Standard{label: "Gildenhome 4th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []},
          %Warlords.Core.Units.Standard{label: "Gildenhome 5th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type :archer, terrain_access: :ground, blessings: []}
        ]}
      }

  """
  @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_army_template)
  end

  @fields ~w(empire_id)a
  defp changeset(stack, attrs) do
    stack
    |> cast(attrs, @fields)
    |> put_units(attrs)
  end

  defp put_units(stack, attrs) do
    units = attrs[:units] || attrs["units"]

    case Enum.count(units) do
      0 -> add_error(stack, :units, "Stack must have at least one unit")
      count when count <= @max_stack_size -> put_change(stack, :units, units)
      _ -> add_error(stack, :units, "Stack can only have up to 8 units")
    end
  end
end
