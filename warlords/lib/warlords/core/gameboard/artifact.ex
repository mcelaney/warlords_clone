defmodule Warlords.Core.Gameboard.Artifact do
  @moduledoc """
  Resources which can be acquired by heros to provide bonuses to their armies.

  Artifacts are found throughout the map my searching ruins with heros. They are
  carried by heros unless dropped. If a hero is killed, all artifacts are dropped
  where they were defeated. Artifacts which have been dropped can be picked up by
  other heros from any empire.
  """

  alias Warlords.Core

  @typedoc """
  Amount of strength to add to hero holding this artifact
  """
  @type strength_modifier :: Core.strength()

  @typedoc """
  Amount of strength to add to all units in the stack
  """
  @type leadership_modifier :: Core.strength()

  @type t :: %__MODULE__{
          artifact_key: Core.artifact_key(),
          label: String.t(),
          strength: strength_modifier(),
          leadership: leadership_modifier()
        }

  @enforce_keys [:artifact_key, :label]
  defstruct [
    :artifact_key,
    :label,
    strength: 0,
    leadership: 0
  ]
end
