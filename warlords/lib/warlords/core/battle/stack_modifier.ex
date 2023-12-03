defmodule Warlords.Core.Battle.StackModifier do
  @moduledoc """
  Responsible for finding the combat modifier for stacks

  **Special Modifier**

  The modifier is 1 for each type of special unit in the stack.

  **Flying Modifier**

  The modifier is 1 if there is are any flying units in the stack.

  **Hero Modifier**

  If the hero's combat strength is 0 to 3, the modifier
  is 0. If the hero's combat strength is 4 to 6, the modifier is 1. If the
  hero's combat strength is 7 or 8, the modifier is 2. If the hero's combat
  strength is 9, the modifier is 3.

  The stength of the leader is assessed after any bonuses are added from flying
  or special units - however hero leadership bonuses are not affected by other
  heros in the stack (although the final leadership bonus is applied to the
  strength of all heros).

  If there are artifacts - the leadership values are added to the modifier
  """

  alias Warlords.Core.Gameboard.Artifact
  alias Warlords.Core.Units.Hero
  alias Warlords.Core.Units.Special
  alias Warlords.Core.Units.Stack

  @type stack_units :: [Hero.t() | Special.t() | Stack.t()]

  @doc """
  Given a stack or a list of units, calculates a leadership bonus

  This leadership bonus should be added to the strength of each unit in a stack
  before battle

  ## Examples

      iex> unit = %Warlords.Core.Units.Special{
      ...>   empire_key: :storm_giants,
      ...>   label: "Wizards",
      ...>   production_key: :wizards,
      ...>   rank: 7,
      ...>   movement: 12,
      ...>   strength: 6,
      ...>   access: :ground
      ...> }
      ...> stack = %Warlords.Core.Units.Stack{
      ...>   empire_key: :storm_giants,
      ...>   units: [unit]
      ...> }
      ...> Warlords.Core.Battle.StackModifier.stack_bonus(stack)
      1
  """
  @spec stack_bonus(Stack.t() | stack_units) :: integer()
  def stack_bonus(%Stack{units: units}), do: stack_bonus(units)

  def stack_bonus(units) do
    {units, 0}
    |> flying_value()
    |> special_value()
    |> hero_value()
    |> elem(1)
  end

  defp hero_value({units, stack}) do
    value =
      Enum.reduce(units, 0, fn
        %Hero{strength: strength, artifacts: artifacts}, acc when strength + stack < 4 ->
          acc + artifact_modifier(artifacts)

        %Hero{strength: strength, artifacts: artifacts}, acc when strength + stack < 7 ->
          acc + 1 + artifact_modifier(artifacts)

        %Hero{strength: strength, artifacts: artifacts}, acc when strength + stack < 9 ->
          acc + 2 + artifact_modifier(artifacts)

        %Hero{artifacts: artifacts}, acc ->
          acc + 3 + artifact_modifier(artifacts)

        _, acc ->
          acc
      end)

    {units, stack + value}
  end

  defp special_value({units, acc}) do
    value =
      units
      |> Enum.reduce(MapSet.new([]), fn
        %Special{production_key: type}, acc -> MapSet.put(acc, type)
        _, acc -> acc
      end)
      |> MapSet.size()

    {units, acc + value}
  end

  defp flying_value({units, acc}) do
    units
    |> Enum.any?(fn
      %{access: :air} -> true
      _ -> false
    end)
    |> case do
      true -> {units, acc + 1}
      false -> {units, acc}
    end
  end

  defp artifact_modifier(artifacts) when is_list(artifacts) do
    artifacts
    |> Enum.reduce(0, fn
      %Artifact{leadership: leadership}, acc -> acc + leadership
      _, acc -> acc
    end)
  end

  defp artifact_modifier(_), do: 0
end
