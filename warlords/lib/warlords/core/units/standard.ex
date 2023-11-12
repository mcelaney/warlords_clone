defmodule Warlords.Core.Units.Standard do
  @moduledoc """
  An army produced by a city

  Standard armies may be produced in cities. Once produced it's expected they
  will be added to a stack, groups of armies which are the actual units players
  control on the gameboard.
  """

  use Warlords.Core.Units.MilitaryUnit

  @doc """
  Generates a new standard unit from the given attributes returned as a tagged tuple

  ## Examples

      iex> Warlords.Core.Units.Standard.new(%{
      ...>   label: "Gildenhome 101st Elven Archers",
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   army_type: :archer,
      ...>   terrain_access: :groud,
      ...>   upkeep: 2
      ...> })

      {
        :ok,
        %Warlords.Core.Units.Standard{label: "Gildenhome 101st Elven Archers",
                                      strength: 4, movement: 12, upkeep: 2,
                                      army_type :archer, terrain_access: :ground,
                                      blessings: []}
      }
  """
  def new(attrs)

  @doc """
  Generates a new standard unit from the given attributes

  ## Examples

      iex> Warlords.Core.Units.Standard.new!(%{
      ...>   label: "Gildenhome 101st Elven Archers",
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   army_type: :archer,
      ...>   terrain_access: :groud,
      ...>   upkeep: 2
      ...> })

      %Warlords.Core.Units.Standard{label: "Gildenhome 101st Elven Archers",
                                    strength: 4, movement: 12, upkeep: 2,
                                    army_type :archer, terrain_access: :ground,
                                    blessings: []}
  """
  def new!(attrs)

  @impl true
  def changeset(army, attrs) do
    army
    |> cast(attrs, ~w(label strength movement army_type terrain_access upkeep)a)
  end
end
