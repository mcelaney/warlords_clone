defmodule Warlords.Core.Gameboard.Quest do
  @moduledoc """
  Structures that are searchable by heros and offer prizes for defeating the
  guardians

  The intention is to have a hero required to search these and, if there is a
  stack defending, to fight that stack alone. If the hero wins, they receive the
  prize. If the hero loses, they are removed from play.
  """

  alias Warlords.Core

  @type t :: %__MODULE__{
          complete: boolean(),
          prize_fn: prize_fn
        }

  @type prize_fn ::
          (Core.empire_key() -> {:allies, [Core.special_unit()]})
          | (Core.empire_key() -> {:artifact, Core.artifact()})
          | (Core.empire_key() -> {:gold, Core.gold()})
          | (Core.empire_key() -> {:altar, integer})

  @enforce_keys [:prize_fn]
  defstruct [
    :prize_fn,
    complete: false
  ]
end
