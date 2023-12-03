defmodule Warlords.Core.Battle.Formation.Defense do
  @moduledoc """
  Responsible for prepping stacks for defense in battle
  """
  alias Warlords.Core.Gameboard.City
  alias Warlords.Core.Gameboard.Tile
  alias Warlords.Core.Units.Stack
  alias Warlords.Core.Battle.StackModifier

  @typedoc """
  Alias for `Warlords.Core.Units.Battle.Unit.t`
  """
  @type defense_unit :: struct

  @doc """
  A defense formation is created from any units on a given set of tiles

  Units from all tiles are combined in to one stack and then given modifiers
  as though they were a single stack.  The origin tile is used to determine
  where to return any surviving units. The target tile is used to determine
  terrain bonuses... which could be necessary if we have connected tiles
  with different terrain types.
  """
  @spec defense_formation(Tile.t() | [Tile.t()], Tile.t(), module, fun()) :: [defense_unit]
  def defense_formation(%Tile{} = origin, %Tile{} = target, template, formation_fn) do
    defense_formation([origin], target, template, formation_fn)
  end

  def defense_formation(origins, %Tile{} = target, template, formation_fn) do
    {defense_bonus, max_strength} = defense_bonuses(origins, template)

    origins
    |> Enum.reduce([], fn
      %Tile{stack: %Stack{}} = origin, acc ->
        formation_fn.(defense_bonus, origin, target, max_strength) ++ acc

      _, acc ->
        acc
    end)
    |> Enum.sort(&(&1.rank < &2.rank))
  end

  defp defense_bonuses(origins, template) do
    structure_bonus = structure_bonus(origins)

    origins
    |> defense_stack_bonus()
    |> Kernel.+(structure_bonus)
    |> defense_return(structure_bonus, template.max_strength)
  end

  defp defense_return(stack_strength, structure_bonus, max) do
    {stack_strength, structure_bonus + max}
  end

  defp structure_bonus(origins) do
    origins
    |> Enum.reduce(0, fn
      %Tile{tower: true}, acc -> 1 + acc
      %Tile{quest: quest}, acc when not is_nil(quest) -> 1 + acc
      %Tile{city: %City{} = city}, acc -> City.defense_modifier(city) + acc
      _, acc -> acc
    end)
  end

  defp defense_stack_bonus(origins) do
    origins
    |> Enum.reduce([], fn
      %{stack: %{units: units}}, acc -> units ++ acc
      _origin, acc -> acc
    end)
    |> StackModifier.stack_bonus()
  end
end
