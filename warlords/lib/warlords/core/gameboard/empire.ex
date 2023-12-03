defmodule Warlords.Core.Gameboard.Empire do
  @moduledoc """
  The character identity of a player in the warlords.

  Each empire starts with it's capital city, a hero, and optionally a set of
  armies. Each empire has unique stat modifiers which are meant to favor a style
  of warlordsplay.
  """

  alias Warlords.Core

  @type t :: %__MODULE__{
          empire_key: Core.empire_key(),
          label: String.t(),
          bank: Core.gold()
        }

  @enforce_keys [:empire_key, :label, :bank]
  defstruct [
    :empire_key,
    :label,
    bank: 0
  ]
end
