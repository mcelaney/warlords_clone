defmodule Warlords.Core.Gameboard.City do
  @moduledoc """
  A city is a location on the map that can be captured by an empire.

  The goal of the warlords is to capture all cities on the map. Once captured, cities
  provide income and allow for the production of a set of army types. Each city
  will provide slightly different stats for the armies it produces.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Warlords.Core
  alias Warlords.Core.Gameboard.ProductionTemplate
  alias Warlords.Core.Gameboard.Empire

  @typedoc """
  An atom used to reference a specific city on the map, e.g. :loremark, :malikor
  """
  @type city_id :: Ecto.Atom

  @typedoc """
  The display name for the city
  """
  @type city_label :: String.t()

  @typedoc """
  The base strength before force combat modifiers are applied
  """
  @type defense_strength :: Core.strength_points()

  @typedoc """
  If a capital city - the related empire
  """
  @type empire_id :: Empire.empire_id()

  @type t :: %__MODULE__{
          id: city_id(),
          label: city_label,
          defense: defense_strength(),
          income: Core.gold(),
          capital: empire_id()
        }

  @max_defense 9

  @primary_key false
  embedded_schema do
    field(:id, Ecto.Atom)
    field(:label, :string)
    field(:defense, :integer)
    field(:income, :integer)
    field(:capital, Ecto.Atom)

    embeds_many(:army_templates, ProductionTemplate)
  end

  @doc """
  Create a new city from the given attributes

  ## Examples

      iex> giant = Warlords.Core.Gameboard.ProductionTemplate.new!(%{type: :giant, time: 2, cost: 4, strength: 6, movement: 12})
      ...> Warlords.Core.Gameboard.City.new(%{
      ...>   id: :stormheim,
      ...>   label: "Stormheim",
      ...>   defense: 6,
      ...>   army_templates: [giant],
      ...>   capital: :storm_giants
      ...> })

      %Warlords.Core.Gameboard.City{
        id: :stormheim,
        label: "Stormheim",
        defense: 6,
        army_templates: [%Warlords.Core.Gameboard.ProductionTemplate{type: :giant, time: 2, cost: 4, strength: 6, movement: 12}],
        capital: :storm_giants
      }

  """
  @spec new!(attrs :: map) :: t() | no_return()
  def new!(attrs) do
    with {:ok, city} <- new(attrs) do
      city
    else
      {:error, changeset} ->
        raise "Failed to create city: #{inspect(changeset.errors)}"
    end
  end

  @doc """
  Create a new city from the given attributes returned as a tagged tuple

  ## Examples

      iex> giant = Warlords.Core.Gameboard.ProductionTemplate.new!(%{type: :giant, time: 2, cost: 4, strength: 6, movement: 12})
      ...> Warlords.Core.Gameboard.City.new(%{
      ...>   id: :stormheim,
      ...>   label: "Stormheim",
      ...>   defense: 6,
      ...>   army_templates: [giant],
      ...>   capital: :storm_giants
      ...> })

      {
        :ok,
        %Warlords.Core.Gameboard.City{
          id: :stormheim,
          label: "Stormheim",
          defense: 6,
          army_templates: [%Warlords.Core.Gameboard.ProductionTemplate{type: :giant, time: 2, cost: 4, strength: 6, movement: 12}],
          capital: :storm_giants
        }
      }
  """
  @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_city)
  end

  @doc """
  Returns true if the current defense is less than the max

  ## Examples

      iex> city = Warlords.Core.Gameboard.City.new!(%{
      ...>   id: :stormheim,
      ...>   label: "Stormheim",
      ...>   defense: 6,
      ...>   army_templates: [],
      ...>   capital: :storm_giants
      ...> })
      ...> Warlords.Core.Gameboard.City.upgradeable?(city)
      true
  """
  @spec upgradeable?(t()) :: boolean()
  def upgradeable?(city), do: city.defense < @max_defense

  @doc """
  Increases defense of a city by 1

  Defense can only be increased up to a max of 9 and adds a modifier to defenders
  while in the city similar to the leadership modifier on a hero.

  ## Examples

      iex> city = Warlords.Core.Gameboard.City.new!(%{
      ...>   id: :stormheim,
      ...>   label: "Stormheim",
      ...>   defense: 6,
      ...>   army_templates: [],
      ...>   capital: :storm_giants
      ...> })
      ...> Warlords.Core.Gameboard.City.upgrade(city)
      {
        :ok,
          %Warlords.Core.Gameboard.City{
          id: :stormheim,
          label: "Stormheim",
          defense: 7,
          army_templates: [],
          capital: :storm_giants
        }
      }
  """
  @spec upgrade(t()) :: {:ok, t()} | {:error, String.t()}
  def upgrade(city) do
    case upgradeable?(city) do
      true ->
        city
        |> change()
        |> put_change(:defense, city.defense + 1)
        |> Ecto.Changeset.apply_action(:new_city)

      false ->
        {:error, "City is already at max defense"}
    end
  end

  @doc """
  Returns a bonus combat modifier for units in a city when it's attacked

  0..1 == 0
  2..6 == 1
  7..8 == 2
  9 == 3

  ## Examples

      iex> city = Warlords.Core.Gameboard.City.new!(%{
      ...>   id: :stormheim,
      ...>   label: "Stormheim",
      ...>   defense: 6,
      ...>   army_templates: [],
      ...>   capital: :storm_giants
      ...> })
      ...> Warlords.Core.Gameboard.City.defense_modifier(city)
      1
  """
  def defense_modifier(city) do
    cond do
      city.defense <= 1 -> 0
      city.defense <= 6 -> 1
      city.defense <= 8 -> 2
      city.defense == 9 -> 3
    end
  end

  @fields ~w(id label defense capital)a
  @required ~w(id label defense)a
  defp changeset(army, attrs) do
    army
    |> cast(attrs, @fields)
    |> put_embed(:army_templates, attrs[:army_templates] || attrs["army_templates"] || [])
    |> validate_required(@required)
  end
end
