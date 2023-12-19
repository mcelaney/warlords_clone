defmodule Warlords.Core.BattleTest do
  use ExUnit.Case

  alias Warlords.Core.Battle
  alias Warlords.Core.Battle.Formation

  describe "perform/2" do
    setup do
      %{
        attackers: [%Formation{rank: 1, strength: 4, origin: {3, 3}, unit: "A"}],
        defenders: [%Formation{rank: 1, strength: 4, origin: {3, 3}, unit: "D"}],
        next_step_fn: fn result, offense, defense -> {result, offense, defense} end
      }
    end

    test "Attacker wins", %{
      attackers: attackers,
      defenders: defenders,
      next_step_fn: next_step_fn
    } do
      pref_off_fn = fn units -> {6, units} end
      pref_def_fn = fn units -> {5, units} end

      {result, offense, defense} =
        Battle.perform(attackers, defenders, pref_off_fn, pref_def_fn, next_step_fn)

      assert result == :attacker_wins
      assert offense == attackers
      assert defense == defenders
    end

    test "Defender wins", %{
      attackers: attackers,
      defenders: defenders,
      next_step_fn: next_step_fn
    } do
      pref_off_fn = fn units -> {5, units} end
      pref_def_fn = fn units -> {6, units} end

      {result, offense, defense} =
        Battle.perform(attackers, defenders, pref_off_fn, pref_def_fn, next_step_fn)

      assert result == :defender_wins
      assert offense == attackers
      assert defense == defenders
    end

    test "tie", %{attackers: attackers, defenders: defenders, next_step_fn: next_step_fn} do
      pref_off_fn = fn units -> {5, units} end
      pref_def_fn = fn units -> {5, units} end

      {result, offense, defense} =
        Battle.perform(attackers, defenders, pref_off_fn, pref_def_fn, next_step_fn)

      assert result == :tie
      assert offense == attackers
      assert defense == defenders
    end

    test "can be called with defaults", %{attackers: attackers, defenders: defenders} do
      {result, units} = Battle.perform(attackers, defenders)

      assert result == :attacker_wins || result == :defender_wins

      case result do
        :defender_wins -> assert units == defenders
        :attacker_wins -> assert units == attackers
      end
    end
  end

  describe "next_unit_attack/2" do
    test "tags the stack with the final strength of next unit without reordering" do
      stack = [
        %Formation{rank: 3, strength: 8, origin: {3, 3}, unit: "A"},
        %Formation{rank: 1, strength: 1, origin: {3, 3}, unit: "B"},
        %Formation{rank: 2, strength: 2, origin: {3, 3}, unit: "C"}
      ]

      die_roll = fn -> 12 end
      assert Battle.next_unit_attack(stack, die_roll) == {20, stack}
    end
  end

  describe "next_step/4" do
    setup do
      %{
        attackers: [
          %Formation{rank: 1, strength: 1, origin: {3, 3}, unit: "A"},
          %Formation{rank: 2, strength: 2, origin: {4, 3}, unit: "A"}
        ],
        defenders: [
          %Formation{rank: 1, strength: 1, origin: {3, 4}, unit: "D"},
          %Formation{rank: 2, strength: 2, origin: {4, 4}, unit: "D"}
        ],
        continue_fn: fn units -> units end
      }
    end

    test "Reduces the losing side", %{
      attackers: [_ | attacker_tail] = attackers,
      defenders: [_ | defender_tail] = defenders,
      continue_fn: continue_fn
    } do
      assert Battle.next_step(:attacker_wins, attackers, defenders, continue_fn) ==
               {attackers, defender_tail}

      assert Battle.next_step(:defender_wins, attackers, defenders, continue_fn) ==
               {attacker_tail, defenders}
    end

    test "Does not reduce a tie", %{
      attackers: attackers,
      defenders: defenders,
      continue_fn: continue_fn
    } do
      assert Battle.next_step(:tie, attackers, defenders, continue_fn) == {attackers, defenders}
    end
  end

  describe "continue/2" do
    setup do
      %{
        attackers: [
          %Formation{rank: 1, strength: 1, origin: {3, 3}, unit: "A"},
          %Formation{rank: 2, strength: 2, origin: {4, 3}, unit: "A"}
        ],
        defenders: [
          %Formation{rank: 1, strength: 1, origin: {3, 4}, unit: "D"},
          %Formation{rank: 2, strength: 2, origin: {4, 4}, unit: "D"}
        ],
        perform_fn: fn attackers, defenders -> {attackers, defenders} end
      }
    end

    test "No defenders left", %{attackers: attackers} do
      assert Battle.continue({attackers, []}, nil) == {:attacker_wins, attackers}
    end

    test "No attackers left", %{defenders: defenders} do
      assert Battle.continue({[], defenders}, nil) == {:defender_wins, defenders}
    end

    test "Both sides have units left", %{
      attackers: attackers,
      defenders: defenders,
      perform_fn: perform_fn
    } do
      assert Battle.continue({attackers, defenders}, perform_fn) == {attackers, defenders}
    end
  end
end
