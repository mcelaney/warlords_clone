defmodule Warlords.Core.Battle.Formation.Attack do
  @moduledoc """
  Responsible for prepping stacks for defense in battle
  """
  alias Warlords.Core.Battle.StackModifier
  alias Warlords.Core.Gameboard.Tile
  alias Warlords.Core.Units.Stack

  @typedoc """
  Alias for `Warlords.Core.Units.Battle.Unit.t`
  """
  @type attack_unit :: struct

  @doc """
  An attack formation is created from a stack before attacking a tile
  """
  @spec attack_formation(Tile.t(), Tile.t(), module, fun) :: [attack_unit()]
  def attack_formation(
        %Tile{stack: %Stack{} = stack} = origin,
        %Tile{} = target,
        template,
        formation_fn
      ) do
    stack
    |> StackModifier.stack_bonus()
    |> formation_fn.(origin, target, template.max_strength)
    |> Enum.sort(&(&1.rank < &2.rank))
  end
end
