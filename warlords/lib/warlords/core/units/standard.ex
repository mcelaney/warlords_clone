defmodule Warlords.Core.Units.Standard do
  @moduledoc """
  An army produced by a city

  Standard armies may be produced in cities. Once produced it's expected they
  will be added to a stack.
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
          move_modifiers: Core.movement_modifiers()
        }

  @enforce_keys [:empire_key, :label, :rank, :movement, :strength, :production_key, :access]

  defstruct [
    :empire_key,
    :label,
    :rank,
    :movement,
    :strength,
    production_key: :hero,
    access: :land,
    upkeep: 0,
    blessings: [],
    strength_modifiers: %{},
    move_modifiers: %{}
  ]
end
