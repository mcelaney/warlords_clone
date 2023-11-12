defmodule Warlords.Core.Units.Hero do
  @moduledoc """
  Leaders on the gameboard

  Heros offer themselves for hire at semi-random intervals. They have no upkeep
  cost. Only heros can search ruins and pick up items. They apply a strength
  modifier to all other armies in their stack.
  """

  use Warlords.Core.Units.MilitaryUnit

  @doc """
  Generates a new hero from the given attributes returned as a tagged tuple

  ## Examples

      iex> Warlords.Core.Units.Hero.new(%{
      ...>   label: "Brave Sir Robin",
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   army_type: :hero,
      ...> })

      {
        :ok,
        %Warlords.Core.Units.Hero{label: "Brave Sir Robin",
                                 strength: 4, movement: 12, upkeep: 0,
                                 army_type: :hero, terrain_access: :rider,
                                 blessings: []}
      }
  """
  def new(attrs)

  @doc """
  Generates a new hero from the given attributes

  ## Examples

      iex> Warlords.Core.Units.Hero.new!(%{
      ...>   label: "Brave Sir Robin",
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   army_type: :hero,
      ...> })

      %Warlords.Core.Units.Hero{label: "Brave Sir Robin",
                                strength: 4, movement: 12, upkeep: 0,
                                army_type: :hero, terrain_access: :rider,
                                blessings: []}
  """
  def new!(attrs)

  @impl true
  def changeset(army, attrs) do
    army
    |> cast(attrs, ~w(label strength movement army_type)a)
    |> put_change(:terrain_access, :rider)
    |> put_change(:upkeep, 0)
  end
end
