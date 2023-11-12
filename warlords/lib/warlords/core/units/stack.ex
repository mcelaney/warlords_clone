defmodule Warlords.Core.Units.Stack do
  @moduledoc """
  A stack of units on the gameboard
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Warlords.Core.Units.Stack.CombatModifier

  @type t :: %__MODULE__{}

  @primary_key false
  embedded_schema do
    field(:units, {:array, :map})
  end

  defdelegate combat_modifier(stack), to: CombatModifier

  @doc """
  Create a new army template from the given attributes

  ## Examples

      iex> Warlords.Core.Units.Stack.new!(%{units: [
      ...>   %Warlords.Core.Units.Hero{label: "Brave Sir Robin", strength: 5, movement: 12, upkeep: 0, army_type: :hero, terrain_access: :rider, blessings: []},
      ...>   %Warlords.Core.Units.Special{label: "Undead", strength: 6, movement: 10, upkeep: 0, army_type: :ghost, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Special{label: "Dragons", strength: 7, movement: 16, upkeep: 0, army_type: :dragon, terrain_access: :air, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 1st Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 2nd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 3rd Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 4th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []},
      ...>   %Warlords.Core.Units.Standard{label: "Gildenhome 5th Elven Archers", strength: 4, movement: 12, upkeep: 2, army_type: :archer, terrain_access: :ground, blessings: []}
      ...> ]})

      %Warlords.Core.Units.Stack{units: [
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

      iex> Warlords.Core.Units.Stack.new!(%{units: [
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
        %Warlords.Core.Units.Stack{units: [
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

  defp changeset(stack, attrs) do
    stack
    |> change()
    |> put_units(attrs)
  end

  defp put_units(stack, attrs) do
    units = attrs[:units] || attrs["units"]

    case Enum.count(units) do
      0 -> add_error(stack, :units, "Stack must have at least one unit")
      count when count < 9 -> put_change(stack, :units, units)
      _ -> add_error(stack, :units, "Stack can only have up to 8 units")
    end
  end
end
