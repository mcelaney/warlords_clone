defmodule Warlords.Core.Gameboard.Item do
  @moduledoc """
  Resources which can be acquired by heros to provide bonuses to their armies.

  Items are found throughout the map my searching ruins with heros. They are
  carried by heros unless dropped. If a hero is killed, all items are dropped
  where they were defeated. Items which have been dropped can be picked up by
  other heros from any empire.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  An atom used to reference a specific item type, e.g. :icesword, :loriel_orb
  """
  @type item_id :: Ecto.Atom

  @typedoc """
  The value of the stats modifier provided by this item
  """
  @type strength_modifier :: integer()

  @typedoc """
  Indicates whether the item affects the hero or a full stack

  - **:strength** - the item affects the hero
  - **:leadership** - the item affects the stack the hero is in
  """
  @type item_type :: :strength | :leadership

  @type t :: %__MODULE__{
          id: item_id(),
          label: String.t(),
          strength: strength_modifier(),
          type: item_type()
        }

  @primary_key false
  embedded_schema do
    field(:id, Ecto.Atom)
    field(:label, :string)
    field(:strength, :integer)
    field(:type, Ecto.Enum, values: [:strength, :leadership])
  end

  @doc """
  Generates a new item from the given attributes

  ## Examples

      iex> Warlords.Core.Gameboard.Item.new!(%{
      ...>   id: :firesword,
      ...>   label: "The Firesword",
      ...>   type: :strength,
      ...>   strength: 2
      ...> })

      %Warlords.Core.Gameboard.Item{id: :firesword, label: "The Firesword", type: :strength, strength: 2}
  """
  @spec new!(attrs :: map) :: t() | no_return()
  def new!(attrs) do
    with {:ok, item} <- new(attrs) do
      item
    else
      {:error, changeset} ->
        raise "Failed to create item: #{inspect(changeset.errors)}"
    end
  end

  @doc """
  Generates a new item from the given attributes returned as a tagged tuple

  ## Examples

      iex> Warlords.Core.Gameboard.Item.new(%{
      ...>   id: :firesword,
      ...>   label: "The Firesword",
      ...>   type: :strength,
      ...>   strength: 2
      ...> })

      {
        :ok,
        %Warlords.Core.Gameboard.Item{id: :firesword, label: "The Firesword", type: :strength, strength: 2}
      }
  """
  @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_item)
  end

  @fields ~w(id label strength type)a
  defp changeset(item, attrs) do
    item
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
