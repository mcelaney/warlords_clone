defmodule Warlords.Core.Units.MilitaryUnit do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Warlords.Core.Units.MilitaryUnit

      alias Warlords.Core
      alias Warlords.Core.Gameboard.Item
      alias Warlords.Core.Gameboard.Terrain
      @behaviour Warlords.Core.Units.MilitaryUnit

      @fields ~w(label strength movement army_type upkeep terrain_access)a

      @type t :: %__MODULE__{
              label: String.t(),
              movement: Core.movement_points(),
              strength: Core.strength_points(),
              army_type: ArmyType.army_type(),
              terrain_access: Terrain.access_type(),
              upkeep: Core.gold(),
              blessings: [Core.blessing()],
              items: [Item.t()]
            }

      @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
      @spec new!(attrs :: map) :: t() | no_return()

      @primary_key false
      embedded_schema do
        field(:label, :string)
        field(:strength, :integer)
        field(:movement, :integer)
        field(:army_type, Ecto.Atom)
        field(:terrain_access, Ecto.Atom)
        field(:upkeep, :integer)
        field(:blessings, {:array, :string}, default: [])

        embeds_many(:items, Item)
      end

      @doc """
      Generates a new military unit

      Examples on concrete implementations
      """
      def new(attrs) do
        %__MODULE__{}
        |> changeset(attrs)
        |> validate_required(@fields)
        |> Ecto.Changeset.apply_action(:new_unit)
      end

      @doc """
      Generates a new military unit

      Examples on concrete implementations
      """
      def new!(attrs) do
        with {:ok, hero} <- new(attrs) do
          hero
        else
          {:error, changeset} ->
            raise "Failed to create unit: #{inspect(changeset.errors)}"
        end
      end
    end
  end

  @callback changeset(Ecto.Schema.t(), attrs :: map) ::
              {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
end
