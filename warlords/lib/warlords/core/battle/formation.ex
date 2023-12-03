defmodule Warlords.Core.Battle.Formation do
  @moduledoc """
  Responsible for creating the formation of units for combat

  Provides structure for stacks of units to be used in combat. Any bonuses or
  penalties are calculated and applied and the units are arranged in order for
  combat.
  """
  alias Warlords.Core
  alias Warlords.Core.Battle.Formation.Attack
  alias Warlords.Core.Battle.Formation.Defense
  alias Warlords.Core.Gameboard.Tile

  @typedoc """
  A record of the original tile location for the unit.

  Used to return surviving units to their original tile.
  """
  @type origin :: Core.grid_position()

  @type t :: %__MODULE__{
          rank: Core.rank(),
          strength: Core.strength(),
          origin: origin,
          unit: Core.unit()
        }

  @enforce_keys ~w(rank origin strength unit)a
  defstruct [
    :rank,
    :origin,
    :strength,
    :unit
  ]

  @doc """
  A defense formation is created from the stack on the tile being attacked

  In a simple case, the origin tile and the target tile are the same. However
  here are also cases (like castles) where more than one tile is connected. If
  that's the case any connected stacks will act as one and any tiles with
  city, tower, or quest bonuses will apply to all connected units.

  Terrain bonuses, however, will be applied based on the terrain of the actual
  tile attacked.

  City, tower, and quest bonuses are the only ones that raise the max_strength,
  giving defenders an advantage when structures are present.
  """
  @spec defense_formation([Tile.t()] | Tile.t(), Tile.t(), module()) :: [Defense.defense_unit()]
  def defense_formation(origin, target, template) do
    Defense.defense_formation(origin, target, template, &to_formation/4)
  end

  @doc """
  An attack formation is created from a stack before attacking a tile

  Terrain bonuses will be applied based on the terrain of the tile attacked.
  """
  @spec attack_formation(Tile.t(), Tile.t(), module()) :: [Attack.attack_unit()]
  def attack_formation(origin, target, template) do
    Attack.attack_formation(origin, target, template, &to_formation/4)
  end

  @spec to_formation(integer, Tile.t(), Tile.t(), integer) :: [
          Defense.defense_unit() | Attack.attack_unit()
        ]
  defp to_formation(
         stack_bonus,
         %Tile{location: origin, stack: stack},
         %Tile{terrain: terrain},
         max_strength
       ) do
    stack.units
    |> Enum.map(fn unit ->
      %__MODULE__{
        rank: unit.rank,
        origin: origin,
        strength: battle_strength(unit, stack_bonus, terrain, max_strength),
        unit: unit
      }
    end)
  end

  defp battle_strength(unit, stack_bonus, terrain, max_strength) do
    unit.blessings
    |> Enum.count()
    |> Kernel.+(unit.strength)
    |> Kernel.+(stack_bonus)
    |> Kernel.+(unit.strength_modifiers[terrain] || 0)
    |> cap_strength(max_strength)
  end

  defp cap_strength(strength, max) when strength > max, do: max
  defp cap_strength(strength, _), do: strength
end
