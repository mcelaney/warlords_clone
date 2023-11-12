defmodule Warlords.Core.Units do
  @moduledoc """
  Units are the armies which players control on the gameboard.

  # Heros

  Heros offer themselves for hire at semi-random intervals. They have no upkeep
  cost. Only heros can search ruins and pick up items. They apply a strength
  modifier to all other armies in their stack.

  # Special Units

  Units can join heros when hired or they can be found in ruins.

  # Standard Units

  Standard armies may be produced in cities. Once produced it's expected they
  will be added to a stack, groups of armies which are the actual units players
  control on the gameboard.
  """

  alias Warlords.Core.Units.Hero
  alias Warlords.Core.Units.Special
  alias Warlords.Core.Units.Stack
  alias Warlords.Core.Units.Standard

  defdelegate new_hero(attrs), to: Hero, as: :new
  defdelegate new_hero!(attrs), to: Hero, as: :new!

  defdelegate new_special_unit(attrs), to: Special, as: :new
  defdelegate new_special_unit!(attrs), to: Special, as: :new!

  defdelegate new_unit(attrs), to: Standard, as: :new
  defdelegate new_unit!(attrs), to: Standard, as: :new!

  defdelegate new_stack(attrs), to: Stack, as: :new
  defdelegate new_stack!(attrs), to: Stack, as: :new!
  defdelegate combat_modifier(stack), to: Stack.CombatModifier
end
