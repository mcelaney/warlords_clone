defmodule Warlords.Core do
  @typedoc """
  Alias for `Warlords.Core.Gameboard.Artifact.t()`
  """
  @type artifact :: struct()

  @typedoc """
  A identifier finding artifacts in templates
  """
  @type artifact_key :: atom

  @typedoc """
  A findable attack modifer

  Blessings can be found in temples around the map.  Each army will receive a
  blessing the first time they enter each temple. So if there are four temples
  an army can seek up to four blessings.

  Each blessing adds one point to attack or defense strength in battle
  """
  @type blessing :: any

  @typedoc """
  Alias for `Warlords.Core.Gameboard.City.t()`
  """
  @type city :: struct()

  @typedoc """
  A identifier finding cities in templates
  """
  @type city_key :: atom

  @typedoc """
  A identifier finding empires in templates
  """
  @type empire_key :: atom

  @typedoc """
  In-game currency

  Gold is earned per turn as income from cities or found in ruins. It is used
  to purchase armies, pay upkeep costs for armies, build structures, and upgrade
  castles and structures.
  """
  @type gold :: integer

  @type grid_position :: {x :: integer, y :: integer}

  @typedoc """
  The number of points a units gets to apply toward movement per turn.

  Each terrain type will have a different movement cost. So if a unit has 12
  movement points and is moving across a terrain type with a cost of 3, it will
  be able to move 4 spaces.
  """
  @type movement :: integer

  @typedoc """
  Amounts to add or subtrack from a unit's movement when traversing various
  terrain
  """
  @type movement_modifiers :: %{terrain_key() => Core.movement()}

  @typedoc """
  The number of turns to product a unit.

  Units will be added on the nth turn after purchased
  """
  @type turns :: integer

  @typedoc """
  Alias for `Warlords.Core.Gameboard.Quest.t()`
  """
  @type quest :: struct()

  @typedoc """
  The relative importance of a given unit type

  Units will fight in order of lowest to highest rank (regardless of strength)

  Icons for units will be determined by the highest rank unit in the stack
  """
  @type rank :: integer

  @typedoc """
  Alias for `Warlords.Core.Units.Stack.t()`
  """
  @type stack :: struct()

  @typedoc """
  Alias for `Warlords.Core.Units.Special.t()`
  """
  @type special_unit :: struct()

  @typedoc """
  Strength is used to calculate both attack and defense values.

  Each unit has a base strength and then modifiers are applied based on factors
  such as terrain efficacy, empire bonuses, blessings, and stack bonuses.
  """
  @type strength :: integer

  @typedoc """
  Amounts to add or subtrack from a unit's strength when attacking or defending
  on various terrain
  """
  @type strength_modifiers :: %{terrain_key() => Core.strength()}

  @typedoc """
  A identifier finding terrain in templates
  """
  @type terrain_key :: atom

  @typedoc """
  Determines what kinds of tiles a unit can move across

  Land and sea units can travel on land and sea tiles, respectively. Air units
  can travel over any tile.

  Rider units are land units that can adopt the terrain access of other units in
  their stack - acting as sea units when stacked with sea units, or air units
  when stacked with air units. When both land and sea units are present - rider
  units will act as sea.
  """
  @type terrain_access :: :land | :sea | :air | :rider

  @type terrain_type :: :land | :sea | :restricted

  @typedoc """
  A identifier finding production instructions in templates
  """
  @type production_key :: atom

  @typedoc """
  Tuple representing the data necessary to produce a standard unit from a
  production template
  """
  @type production_instructions ::
          {production_key, gold(), movement, strength, turns}

  @typedoc """
  Alias for `Warlords.Core.Units.t()`
  """
  @type unit :: struct()
end
