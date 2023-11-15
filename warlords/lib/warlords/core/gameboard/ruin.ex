defmodule Warlords.Core.Gameboard.Ruin do
  @moduledoc """
  Structures that are searchable by heros and offer prizes for defeating the
  guardians

  The intention is to have a hero required to search these and, if there is a
  stack defending, to fight that stack alone. If the hero wins, they receive the
  prize. If the hero loses, they are removed from play.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Warlords.Core.Gameboard.Item
  alias Warlords.Core.Units.Special
  alias Warlords.Core.Units.Stack

  @typedoc """
  Units which need to be defeated in order to claim the prize
  """
  @type defender :: Stack.t()

  @typedoc """
  What is found in the ruin after defeating the guardians
  """
  @type prize :: prize_units | prize_item | prize_gold
  @type prize_units :: [Special.t()]
  @type prize_item :: Item.t()
  @type prize_gold :: Core.gold()

  @typedoc """
  These are the types of ruins that can be found - their effect is intended to
  be cosmetic... however maps gameboards can be generated which imply more
  meaning (maybe tombs are guarded by undead, or dungeaon battles joined by
  the full stack, etc.)
  """
  @type ruin_type :: :ruin | :temple | :dungeon | :tomb

  @type t :: %__MODULE__{
          defense: Core.strength_points(),
          gold: prize_gold(),
          item: prize_item(),
          units: prize_units(),
          stack: defender()
        }

  @primary_key false
  embedded_schema do
    field(:type, Ecto.Enum, values: [:ruin, :temple, :dungeon, :tomb])
    field(:defense, :integer)
    field(:gold, :integer)
    embeds_one(:item, Item, on_replace: :delete)
    embeds_many(:units, Special, on_replace: :delete)
    embeds_one(:stack, Stack, on_replace: :delete)
  end

  @doc """
  Generates a new ruin from the given attributes.

  ## Examples

      Defeat two undead and receive the Firesword, 5000 gold, and have two
      dragons join your army. In practice there would normally only be one prize.

      iex> Warlords.Core.Gameboard.Ruin.new!(%{
      ...>   type: :tomb,
      ...>   gold: 5000,
      ...>   item: %Warlords.Core.Gameboard.Item{id: :firesword, label: "The Firesword", type: :strength, strength: 2},
      ...>   units: [
      ...>     %Warlords.Core.Units.Special{label: "Dragon", army_type: :dragon, strength: 9, movement: 24, terrain_access: :air},
      ...>     %Warlords.Core.Units.Special{label: "Dragon", army_type: :dragon, strength: 9, movement: 24, terrain_access: :air}
      ...>   ],
      ...>   stack: %Warlords.Core.Units.Stack{units: [
      ...>     %Warlords.Core.Units.Special{label: "Undead", strength: 4, movement: 12, upkeep: 0, army_type: :ghost, terrain_access: :ground},
      ...>     %Warlords.Core.Units.Special{label: "Undead", strength: 4, movement: 12, upkeep: 0, army_type: :ghost, terrain_access: :ground}
      ...>   ]}
      ...> })

      %Warlords.Core.Gameboard.Ruin{
        type: :tomb,
        gold: 5000,
        item: %Warlords.Core.Gameboard.Item{id: :firesword, label: "The Firesword", type: :strength, strength: 2},
        units: [
          %Warlords.Core.Units.Special{label: "Dragon", army_type: :dragon, strength: 9, movement: 24, terrain_access: :air},
          %Warlords.Core.Units.Special{label: "Dragon", army_type: :dragon, strength: 9, movement: 24, terrain_access: :air}
        ],
        stack: %Warlords.Core.Units.Stack{units: [
          %Warlords.Core.Units.Special{label: "Undead", strength: 4, movement: 12, upkeep: 0, army_type: :ghost, terrain_access: :ground},
          %Warlords.Core.Units.Special{label: "Undead", strength: 4, movement: 12, upkeep: 0, army_type: :ghost, terrain_access: :ground}
        ]}
      }

      No Defender - so you the hero just receives the cash prize.

      iex> Warlords.Core.Gameboard.Ruin.new!(%{
      ...>   type: :temple,
      ...>   gold: 5000,
      ...> })

      %Warlords.Core.Gameboard.Ruin{type: :temple, gold: 5000}
  """
  def new!(attrs) do
    with {:ok, ruin} <- new(attrs) do
      ruin
    else
      {:error, changeset} ->
        raise "Failed to create ruin: #{inspect(changeset.errors)}"
    end
  end

  @doc """
  Generates a new ruin from the given attributes

  ## Examples

      iex> Warlords.Core.Gameboard.Ruin.new(%{
      ...>   type: :tomb,
      ...>   gold: 5000,
      ...>   item: %Warlords.Core.Gameboard.Item{id: :firesword, label: "The Firesword", type: :strength, strength: 2},
      ...>   units: [
      ...>     %Warlords.Core.Units.Special{label: "Dragon", army_type: :dragon, strength: 9, movement: 24, terrain_access: :air},
      ...>     %Warlords.Core.Units.Special{label: "Dragon", army_type: :dragon, strength: 9, movement: 24, terrain_access: :air}
      ...>   ],
      ...>   stack: %Warlords.Core.Units.Stack{units: [
      ...>     %Warlords.Core.Units.Special{label: "Undead", strength: 4, movement: 12, upkeep: 0, army_type: :ghost, terrain_access: :ground},
      ...>     %Warlords.Core.Units.Special{label: "Undead", strength: 4, movement: 12, upkeep: 0, army_type: :ghost, terrain_access: :ground}
      ...>   ]}
      ...> })

      {
        :ok,
        %Warlords.Core.Gameboard.Ruin{
          type: :tomb,
          gold: 5000,
          item: %Warlords.Core.Gameboard.Item{id: :firesword, label: "The Firesword", type: :strength, strength: 2},
          units: [
            %Warlords.Core.Units.Special{ label: "Dragon", army_type: :dragon, strength: 9, movement: 24, terrain_access: :air},
            %Warlords.Core.Units.Special{label: "Dragon", army_type: :dragon, strength: 9, movement: 24, terrain_access: :air}
          ],
          stack: %Warlords.Core.Units.Stack{units: [
            %Warlords.Core.Units.Special{label: "Undead", strength: 4, movement: 12, upkeep: 0, army_type: :ghost, terrain_access: :ground},
            %Warlords.Core.Units.Special{label: "Undead", strength: 4, movement: 12, upkeep: 0, army_type: :ghost, terrain_access: :ground}
          ]}
        }
      }
  """
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_ruin)
  end

  @fields ~w(gold type)a
  defp changeset(ruin, attrs) do
    ruin
    |> cast(attrs, @fields)
    |> put_change(:defense, 1)
    |> put_embed(:item, attrs[:item] || attrs["item"])
    |> put_embed(:units, attrs[:units] || attrs["units"] || [])
    |> put_embed(:stack, attrs[:stack] || attrs["stack"])
    |> validate_required([:type])
  end
end
