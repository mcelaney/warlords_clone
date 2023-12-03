defmodule Warlords.Core.Gameboard.City do
  @moduledoc """
  A city is a location on the map that can be captured by an empire.

  The goal of the warlords is to capture all cities on the map. Once captured, cities
  provcity_keye income and allow for the production of a set of army types. Each city
  will provcity_keye slightly different stats for the armies it produces.
  """

  alias Warlords.Core

  @max_level 9

  @typedoc """
  Maturity of the city defenses

  Users can pay to upgrade city defenses which have an impact on combat
  modifiers. These modifiers can increase the max stregth of defenders.

  See `Warlords.Core.Gameboard.City.defense_modifier/1` for more details.
  """
  @type level :: non_neg_integer()

  @typedoc """
  Amount of gold a city earns per turn
  """
  @type income :: Core.gold()

  @typedoc """
  The number of units which have been produced by the city
  """
  @type production_count :: non_neg_integer()

  @type t :: %__MODULE__{
          city_key: Core.city_key(),
          label: String.t(),
          level: level(),
          income: Core.gold(),
          production_count: 0,
          army_templates: [Core.production_instructions()]
        }

  @enforce_keys [:city_key, :label, :level]
  defstruct [
    :city_key,
    :label,
    :level,
    income: 0,
    production_count: 0,
    army_templates: []
  ]

  @doc """
  Returns true if the current level is less than the max

  ## Examples

      iex> city = %Warlords.Core.Gameboard.City{
      ...>   city_key: :stormheim,
      ...>   label: "Stormheim",
      ...>   level: 6
      ...> }
      ...> Warlords.Core.Gameboard.City.upgradeable?(city)
      true

      iex> city = %Warlords.Core.Gameboard.City{
      ...>   city_key: :stormheim,
      ...>   label: "Stormheim",
      ...>   level: 9
      ...> }
      ...> Warlords.Core.Gameboard.City.upgradeable?(city)
      false
  """
  @spec upgradeable?(t()) :: boolean()
  def upgradeable?(city), do: city.level < @max_level

  @doc """
  Increases level of a city by 1

  Defense can only be increased up to a max of 9 and adds a modifier to defenders
  while in the city similar to the leadership modifier on a hero.

  ## Examples

      iex> city = %Warlords.Core.Gameboard.City{
      ...>   city_key: :stormheim,
      ...>   label: "Stormheim",
      ...>   level: 6
      ...> }
      ...> Warlords.Core.Gameboard.City.upgrade(city)
      {
        :ok,
          %Warlords.Core.Gameboard.City{
          city_key: :stormheim,
          label: "Stormheim",
          level: 7
        }
      }

      iex> city = %Warlords.Core.Gameboard.City{
      ...>   city_key: :stormheim,
      ...>   label: "Stormheim",
      ...>   level: 9
      ...> }
      ...> Warlords.Core.Gameboard.City.upgrade(city)
      {:error, "City is already at max level"}
  """
  @spec upgrade(t()) :: {:ok, t()} | {:error, String.t()}
  def upgrade(city) do
    case upgradeable?(city) do
      true -> {:ok, Map.update!(city, :level, fn _ -> city.level + 1 end)}
      false -> {:error, "City is already at max level"}
    end
  end

  @doc """
  Returns a bonus combat modifier for units in a city when it's attacked

  0..1 == 0
  2..6 == 1
  7..8 == 2
  9 == 3

  ## Examples

      iex> city = %Warlords.Core.Gameboard.City{
      ...>   city_key: :stormheim,
      ...>   label: "Stormheim",
      ...>   level: 6
      ...> }
      ...> Warlords.Core.Gameboard.City.defense_modifier(city)
      1
  """
  def defense_modifier(city) do
    cond do
      city.level <= 1 -> 0
      city.level <= 6 -> 1
      city.level <= 8 -> 2
      city.level >= 9 -> 3
    end
  end
end
