defmodule Warlords.Core.Gameboard.Tile do
  @moduledoc """
  A unique position on the gameboard
  """
  alias Warlords.Core

  @typedoc """
  A list of tiles intended to act as one location, e.g. a city

  This is a list of positions, e.g. [{1,1}, {1,2}, {2,1}, {2,2}] and the list
  should be inclusive of the current tile.
  """
  @type connected_tiles :: [{x :: integer, y :: integer}]

  @typedoc """
  The placement of a tile on the gameboard

  "X" is the horizontal axis, "Y" is the vertical axis. The origin is at {1,1}
  """
  @type grid_position :: {x :: integer, y :: integer}

  @type terrain_type :: :bridge | :forest | :hill | :marsh | :mountain | :plain | :road | :water

  @type icon_type ::
          :bridge
          | :city_ne
          | :city_nw
          | :city_se
          | :city_sw
          | :dungeon
          | :forest
          | :hill
          | :marsh
          | :mountain
          | :plain
          | :road
          | :ruins
          | :temple
          | :tomb
          | :water

  @type(quest_type :: :dungeon, :ruins, :temple, :tomb)

  @type t :: %__MODULE__{
          location: grid_position,
          terrain: terrain_type,
          icon: icon_type,
          occupied_by: Core.empire_key(),
          connected: connected_tiles,
          tower: boolean,
          quest: Core.quest(),
          city: Core.city(),
          stack: Core.stack(),
          artifacts: [Core.artifact()]
        }

  @enforce_keys ~w(location terrain icon)a

  defstruct [
    :location,
    :terrain,
    :icon,
    :occupied_by,
    :connected,
    :tower,
    :quest,
    :city,
    :stack,
    artifacts: []
  ]
end
