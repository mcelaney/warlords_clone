defmodule Warlords.Core.Units.Stack.CombatModifier do
  @moduledoc """
  Responsible for finding the combat modifier for stacks

  **Hero Modifier**

  If the hero's combat strength is 0 to 3, the modifier
  is 0. If the hero's combat strength is 4 to 6, the modifier is 1. If the
  hero's combat strength is 7 or 8, the modifier is 2. If the hero's combat
  strength is 9, the modifier is 3.

  If there are leadership items - the strength is added to the modifier

  **Special Modifier**

  The modifier is 1 for each type of special unit in the stack.

  **Flying Modifier**

  The modifier is 1 for each flying unit in the stack.
  """

  alias Warlords.Core.Gameboard.Item
  alias Warlords.Core.Units.Hero
  alias Warlords.Core.Units.Special

  @doc """
  Calculates the combat modifier for the given stack

  ## Examples

      iex> stack = Warlords.Core.Units.Stack.new!(%{units: [
      ...>   %Warlords.Core.Units.Hero{
      ...>     label: "Brave Sir Robin",
      ...>     strength: 7,
      ...>     movement: 12,
      ...>     upkeep: 0,
      ...>     army_type: :hero,
      ...>     terrain_access: :rider,
      ...>     items: [%Warlords.Core.Gameboard.Item{
      ...>       id: :firesword,
      ...>       label: "The Firesword",
      ...>       type: :leadership,
      ...>       strength: 2
      ...>     }]
      ...>   },
      ...>   %Warlords.Core.Units.Special{
      ...>     label: "Undead",
      ...>     strength: 6,
      ...>     movement: 10,
      ...>     upkeep: 0,
      ...>     army_type: :ghost,
      ...>     terrain_access: :ground
      ...>   },
      ...>   %Warlords.Core.Units.Special{
      ...>     label: "Dragons",
      ...>     strength: 7,
      ...>     movement: 16,
      ...>     upkeep: 0,
      ...>     army_type: :dragon,
      ...>     terrain_access: :air
      ...>   },
      ...>   %Warlords.Core.Units.Standard{
      ...>     label: "Gildenhome 1st Elven Archers",
      ...>     strength: 4,
      ...>     movement: 12,
      ...>     upkeep: 2,
      ...>     army_type: :archer,
      ...>     terrain_access: :ground,
      ...>     blessings: ["won't matter"]
      ...>   }
      ...> ]})
      ...> Warlords.Core.Units.Stack.combat_modifier(stack)
      7
  """
  @spec combat_modifier(Stack.t()) :: integer()
  def combat_modifier(%{units: units}) do
    {units, 0}
    |> hero_value()
    |> special_value()
    |> flying_value()
    |> cap()
  end

  defp hero_value({units, acc}) when acc > 8, do: {units, 9}

  defp hero_value({units, acc}) do
    value =
      Enum.reduce(units, 0, fn
        %Hero{strength: strength, items: items}, acc when strength < 4 ->
          acc + acfm_leadership_items(items)

        %Hero{strength: strength, items: items}, acc when strength < 7 ->
          acc + 1 + acfm_leadership_items(items)

        %Hero{strength: strength, items: items}, acc when strength < 9 ->
          acc + 2 + acfm_leadership_items(items)

        %Hero{strength: strength, items: items}, acc when strength > 8 ->
          acc + 3 + acfm_leadership_items(items)

        _, acc ->
          acc
      end)

    {units, acc + value}
  end

  defp special_value({units, acc}) when acc > 8, do: {units, 9}

  defp special_value({units, acc}) do
    value =
      units
      |> Enum.reduce(MapSet.new([]), fn
        %Special{army_type: army_type}, acc -> MapSet.put(acc, army_type)
        _, acc -> acc
      end)
      |> MapSet.size()

    {units, acc + value}
  end

  defp flying_value({units, acc}) when acc > 8, do: {units, 9}

  defp flying_value({units, acc}) do
    value =
      units
      |> Enum.reduce(0, fn
        %{terrain_access: :air}, acc -> acc + 1
        _, acc -> acc
      end)

    {units, acc + value}
  end

  defp acfm_leadership_items(items) when is_list(items) do
    items
    |> Enum.reduce(0, fn
      %Item{type: :leadership, strength: strength}, acc -> acc + strength
      _, acc -> acc
    end)
  end

  defp acfm_leadership_items(_), do: 0

  defp cap({_units, acc}) when acc > 8, do: 9
  defp cap({_units, acc}), do: acc
end
