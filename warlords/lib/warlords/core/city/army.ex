defmodule Warlords.Core.City.Army do
  @moduledoc """
  An army produced by a city

  Standard armies may be produced in cities. Once produced it's expected they
  will be added to a stack, groups of armies which are the actual units players
  control on the gameboard.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Warlords.Core
  alias Warlords.Core.City.Army.Label
  alias Warlords.Core.Gameboard.ArmyType
  alias Warlords.Core.Gameboard.City

  @type t :: %__MODULE__{
          label: Label.t(),
          movement: movement_limit(),
          strength: attack_strength(),
          army_type: ArmyType.army_id(),
          terrain_access: ArmyType.terrain_access(),
          upkeep: Core.gold(),
          blessings: [Core.blessing()]
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

  @typedoc """
  The expected new army attributes
  """
  @type valid_attrs :: %{
          city: City.city_label(),
          nth: Label.nth_count(),
          strength: attack_strength(),
          movement: movement_limit(),
          type: ArmyType.t(),
          upkeep: Core.gold()
        }

  @primary_key false
  embedded_schema do
    field(:label, :string)
    field(:strength, :integer)
    field(:movement, :integer)
    field(:army_type, Ecto.Atom)
    field(:terrain_access, Ecto.Atom)
    field(:upkeep, :integer)
    field(:blessings, {:array, :string}, default: [])
  end

  @doc """
  Generates a new army type from the given attributes

  ## Examples

      iex> Warlords.Core.City.Army.new(%{
      ...>   city: "Gildenhome",
      ...>   nth: 101,
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   upkeep: 2,
      ...>   type: %Warlords.Core.Gameboard.ArmyType{id: :archer, label: "Elven Archers", type: :standard, access: :groud}
      ...> })

      %Warlords.Core.City.Army{label: "Gildenhome 101st Elven Archers",
                               strength: 4, movement: 12, upkeep: 2,
                               army_type :archer, terrain_access: :ground,
                               blessings: []}
  """
  @spec new!(valid_attrs()) :: t() | no_return()
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

      iex> Warlords.Core.City.Army.new(%{
      ...>   city: "Gildenhome",
      ...>   nth: 101,
      ...>   strength: 4,
      ...>   movement: 12,
      ...>   upkeep: 2,
      ...>   type: %Warlords.Core.Gameboard.ArmyType{id: :archer, label: "Elven Archers", type: :standard, access: :groud}
      ...> })

      {
        :ok,
        %Warlords.Core.City.Army{label: "Gildenhome 101st Elven Archers",
                                 strength: 4, movement: 12, upkeep: 2,
                                 army_type :archer, terrain_access: :ground,
                                 blessings: []}
      }
  """
  @spec new(valid_attrs) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_army)
  end

  @fields ~w(strength movement upkeep)a
  @required ~w(strength movement army_type terrain_access upkeep)a
  defp changeset(army, attrs) do
    army
    |> cast(attrs, @fields)
    |> put_army_type_info(attrs)
    |> validate_required(@required)
  end

  defp put_army_type_info(army, attrs) do
    case attrs[:type] || attrs["type"] do
      nil ->
        add_error(army, :type, "can't be blank")

      %ArmyType{} = type ->
        army
        |> put_change(:army_type, type.id)
        |> put_change(:terrain_access, type.access)
        |> put_label(type.label, attrs)

      _ ->
        add_error(army, :type, "must be an ArmyType")
    end
  end

  defp put_label(army, type_label, attrs) do
    cond do
      is_nil(attrs[:city] || attrs["city"]) ->
        add_error(army, :city, "can't be blank")

      is_nil(attrs[:nth] || attrs["nth"]) ->
        add_error(army, :nth, "can't be blank")

      true ->
        put_change(army, :label, Label.build(type_label, attrs))
    end
  end
end
