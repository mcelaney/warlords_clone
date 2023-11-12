defmodule Warlords.Core.Units.Special do
  @moduledoc """
  Special armies which offer to join Heros.

  Special units can join heros when hired or they can be found in ruins.
  """

  use Warlords.Core.Units.MilitaryUnit

  @doc """
  Generates a new special unit from the given attributes returned as a tagged
  tuple

  ## Examples

      iex> Warlords.Core.Units.Special.new(%{
      ...>   label: "Undead",
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   army_type: :ghost,
      ...>   terrain_access: :ground
      ...> })

      {
        :ok,
        %Warlords.Core.Units.Special{label: "Undead",
                                    strength: 4, movement: 12, upkeep: 0,
                                    army_type: :ghost, terrain_access: :ground,
                                    blessings: []}
      }
  """
  def new(attrs)

  @doc """
  Generates a new special unit from the given attributes

  ## Examples

      iex> Warlords.Core.Units.Special.new!(%{
      ...>   label: "Undead",
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   army_type: :ghost,
      ...>   terrain_access: :ground
      ...> })

      %Warlords.Core.Units.Special{label: "Undead",
                                  strength: 4, movement: 12, upkeep: 0,
                                  army_type: :ghost, terrain_access: :ground,
                                  blessings: []}
  """
  def new!(attrs)

  @impl true
  def changeset(army, attrs) do
    army
    |> cast(attrs, ~w(label strength movement army_type terrain_access)a)
    |> put_change(:upkeep, 0)
  end
end
