defmodule Warlords.Core.BattleTest do
  use ExUnit.Case

  import Warlords.GameboardFixtures
  import Warlords.UnitFixtures
  alias Warlords.Core.Battle
  alias Warlords.Mock.RandomNumber
  alias Warlords.Mock.Template

  describe "perform/5" do
    test "attacker wins" do
      attacker_units = standard_fixture(%{strength: 5})

      attacker =
        tile_fixture(%{stack: stack_fixture(%{empire_key: :elvallie, units: [attacker_units]})})

      target_units = standard_fixture(%{strength: 5})

      target =
        tile_fixture(%{stack: stack_fixture(%{empire_key: :storm_giants, units: [target_units]})})

      attacker_roll_1 = 5
      defender_roll_1 = 4
      RandomNumber.start_link([attacker_roll_1, defender_roll_1])

      {winner, [result_unit | _] = remaining_units} =
        Battle.perform(attacker, [target], target, &RandomNumber.pop/0, Template)

      expected_number_of_turns = RandomNumber.is_empty()
      RandomNumber.stop()

      assert expected_number_of_turns
      assert winner == :attackers
      assert Enum.count(remaining_units) == 1
      assert attacker_units == result_unit.unit
    end

    test "attacker defeats multiple defenders" do
      attacker_units = standard_fixture(%{strength: 5})

      attacker =
        tile_fixture(%{stack: stack_fixture(%{empire_key: :elvallie, units: [attacker_units]})})

      target_units = [standard_fixture(%{strength: 5}), standard_fixture(%{strength: 5})]

      target =
        tile_fixture(%{stack: stack_fixture(%{empire_key: :storm_giants, units: target_units})})

      attacker_roll_1 = 5
      defender_roll_1 = 4
      attacker_roll_2 = 5
      defender_roll_2 = 4

      RandomNumber.start_link([attacker_roll_1, defender_roll_1, attacker_roll_2, defender_roll_2])

      {winner, remaining_units} =
        Battle.perform(attacker, [target], target, &RandomNumber.pop/0, Template)

      expected_number_of_turns = RandomNumber.is_empty()
      RandomNumber.stop()

      assert expected_number_of_turns
      assert winner == :attackers
      assert Enum.count(remaining_units) == 1
    end

    test "attacker loses a unit but wins multiple defenders" do
      attacker_1 = standard_fixture(%{strength: 5, index: 1})
      attacker_2 = standard_fixture(%{strength: 5, index: 2})

      attacker =
        tile_fixture(%{
          stack: stack_fixture(%{empire_key: :elvallie, units: [attacker_1, attacker_2]})
        })

      target_units = [standard_fixture(%{strength: 5})]

      target =
        tile_fixture(%{stack: stack_fixture(%{empire_key: :storm_giants, units: target_units})})

      # attack loses first round
      attacker_roll_1 = 4
      defender_roll_1 = 5
      # attack wins second round
      attacker_roll_2 = 5
      defender_roll_2 = 4

      RandomNumber.start_link([attacker_roll_1, defender_roll_1, attacker_roll_2, defender_roll_2])

      {winner, [result_unit | _] = remaining_units} =
        Battle.perform(attacker, [target], target, &RandomNumber.pop/0, Template)

      expected_number_of_turns = RandomNumber.is_empty()
      RandomNumber.stop()

      assert expected_number_of_turns
      assert winner == :attackers
      assert Enum.count(remaining_units) == 1
      # attacker 1 eliminated in the first round
      # units attack in ascending index order
      assert attacker_2 == result_unit.unit
    end

    test "ties reroll" do
      attacker_units = standard_fixture(%{strength: 5})

      attacker =
        tile_fixture(%{stack: stack_fixture(%{empire_key: :elvallie, units: [attacker_units]})})

      target_units = [standard_fixture(%{strength: 5})]

      target =
        tile_fixture(%{stack: stack_fixture(%{empire_key: :storm_giants, units: target_units})})

      attacker_roll_1 = 4
      defender_roll_1 = 4
      attacker_roll_2 = 5
      defender_roll_2 = 4

      RandomNumber.start_link([attacker_roll_1, defender_roll_1, attacker_roll_2, defender_roll_2])

      {winner, remaining_units} =
        Battle.perform(attacker, [target], target, &RandomNumber.pop/0, Template)

      expected_number_of_turns = RandomNumber.is_empty()
      RandomNumber.stop()

      assert expected_number_of_turns
      assert winner == :attackers
      assert Enum.count(remaining_units) == 1
    end

    test "defender wins" do
      attacker_units = standard_fixture(%{strength: 5})

      attacker =
        tile_fixture(%{stack: stack_fixture(%{empire_key: :elvallie, units: [attacker_units]})})

      target_units = standard_fixture(%{strength: 5})

      target =
        tile_fixture(%{stack: stack_fixture(%{empire_key: :storm_giants, units: [target_units]})})

      attacker_roll_1 = 4
      defender_roll_1 = 5
      RandomNumber.start_link([attacker_roll_1, defender_roll_1])

      {winner, [result_unit | _] = remaining_units} =
        Battle.perform(attacker, [target], target, &RandomNumber.pop/0, Template)

      expected_number_of_turns = RandomNumber.is_empty()
      RandomNumber.stop()

      assert expected_number_of_turns
      assert winner == :defenders
      assert Enum.count(remaining_units) == 1
      assert target_units == result_unit.unit
    end
  end
end
