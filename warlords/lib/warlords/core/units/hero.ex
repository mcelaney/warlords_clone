defmodule Warlords.Core.Units.Hero do
  @moduledoc """
  Leaders on the gameboard

  Heros offer themselves for hire at semi-random intervals. They have no upkeep
  cost. Only heros can search ruins and pick up artifacts. They apply a strength
  modifier to all other armies in their stack.
  """

  alias Warlords.Core

  @type t :: %__MODULE__{
          empire_key: Core.empire_key(),
          label: String.t(),
          rank: Core.rank(),
          movement: Core.movement(),
          strength: Core.strength(),
          production_key: Core.production_key(),
          access: Core.terrain_access(),
          upkeep: Core.gold(),
          blessings: [Core.blessing()],
          strength_modifiers: Core.strength_modifiers(),
          move_modifiers: Core.movement_modifiers(),
          artifacts: [Core.artifact()]
        }

  @enforce_keys [:empire_key, :label, :rank, :movement, :strength]

  defstruct [
    :empire_key,
    :label,
    :rank,
    :movement,
    :strength,
    production_key: :hero,
    access: :rider,
    upkeep: 0,
    blessings: [],
    strength_modifiers: %{},
    move_modifiers: %{},
    artifacts: []
  ]
end
