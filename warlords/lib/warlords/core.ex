defmodule Warlords.Core do
  @typedoc """
  A findable attack modifer

  Blessings can be found in temples around the map.  Each army will receive a
  blessing the first time they enter each temple. So if there are four temples
  an army can seek up to four blessings.

  Each blessing adds one point to attack or defense strength in battle
  """
  @type blessing :: String.t()

  @typedoc """
  In-game currency

  Gold is earned per turn as income from cities or found in ruins. It is used
  to purchase armies, pay upkeep costs for armies, build structures, and upgrade
  castles and structures.
  """
  @type gold :: integer
end
