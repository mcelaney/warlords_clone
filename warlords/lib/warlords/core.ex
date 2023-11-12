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

  @typedoc """
  The number of points a units gets to apply toward movement per turn.

  Each terrain type will have a different movement cost. So if a unit has 12
  movement points and is moving across a terrain type with a cost of 3, it will
  be able to move 4 spaces.
  """
  @type movement_points :: integer

  @typedoc """
  Strength is used to calculate both attack and defense values.

  Each unit has a base strength and then modifiers are applied based on factors
  such as terrain efficacy, empire bonuses, blessings, and stack bonuses.
  """
  @type strength_points :: integer
end
