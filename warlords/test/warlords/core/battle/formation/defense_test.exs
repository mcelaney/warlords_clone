defmodule Warlords.Core.Battle.Formation.DefenseTest do
  use ExUnit.Case, async: true

  import Warlords.GameboardFixtures
  import Warlords.UnitFixtures
  alias Warlords.Core.Battle.Formation

  describe "defense_formation/3 with no structure" do
    test "with no modifiers" do
      unit = standard_fixture(%{access: :ground, rank: 4, strength: 3, strength_modifiers: %{}})
      origin = defense_formation_tile_fixture({30, 40}, :hills, [unit])
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      assert result.strength == 3
      assert result.unit == unit
    end

    test "with adds to strength if there are terrain modifiers" do
      units = [
        standard_fixture(%{
          access: :ground,
          rank: 4,
          strength: 3,
          strength_modifiers: %{plains: 1}
        })
      ]

      origin = defense_formation_tile_fixture({30, 40}, :hills, units)
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      assert result.strength == 4
    end

    test "subtracts from strength if there are terrain modifiers" do
      units = [
        standard_fixture(%{
          access: :ground,
          rank: 4,
          strength: 3,
          strength_modifiers: %{plains: -1}
        })
      ]

      origin = defense_formation_tile_fixture({30, 40}, :hills, units)
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      assert result.strength == 2
    end

    test "caps strength" do
      units = [
        standard_fixture(%{access: :ground, rank: 4, strength: 10, strength_modifiers: %{}})
      ]

      origin = defense_formation_tile_fixture({30, 40}, :hills, units)
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      # Max was set to 9 in the mock template
      assert result.strength == 9
    end

    test "terrain and stack bonuses stack" do
      units = [
        standard_fixture(%{access: :air, rank: 4, strength: 3, strength_modifiers: %{plains: 1}})
      ]

      origin = defense_formation_tile_fixture({30, 40}, :hills, units)
      target = tile_fixture(%{terrain: :plains})

      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      # 1 for air, 1 for plains, plus 3 original strength
      assert result.strength == 5
    end

    test "orders units by rank ascending" do
      unit1 = standard_fixture(%{rank: 1})
      unit2 = standard_fixture(%{rank: 2})
      unit3 = standard_fixture(%{rank: 3})
      unit4 = standard_fixture(%{rank: 4})
      origin = defense_formation_tile_fixture({30, 40}, :hills, [unit4, unit3, unit1, unit2])
      target = tile_fixture()

      [%{unit: res1}, %{unit: res2}, %{unit: res3}, %{unit: res4}] =
        Formation.defense_formation(origin, target, Warlords.Mock.Template)

      assert res1.rank == 1
      assert res2.rank == 2
      assert res3.rank == 3
      assert res4.rank == 4
    end
  end

  describe "defense_formation/3 with a tower" do
    test "with no modifiers adds a point of strength" do
      unit = standard_fixture(%{access: :ground, rank: 4, strength: 3, strength_modifiers: %{}})
      stack = Warlords.UnitFixtures.stack_fixture(%{units: [unit]})
      origin = tile_fixture(%{stack: stack, terrain: :hills, location: {30, 40}, tower: true})
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.strength == 4
    end

    test "increases the cap" do
      unit = standard_fixture(%{access: :ground, rank: 4, strength: 9, strength_modifiers: %{}})
      stack = Warlords.UnitFixtures.stack_fixture(%{units: [unit]})
      origin = tile_fixture(%{stack: stack, terrain: :hills, location: {30, 40}, tower: true})
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      # Max was set to 9 in the mock template
      assert result.strength == 10
    end

    test "tower and stack bonuses stack" do
      units = [standard_fixture(%{access: :air, rank: 4, strength: 3})]
      stack = Warlords.UnitFixtures.stack_fixture(%{units: units})
      origin = tile_fixture(%{stack: stack, terrain: :hills, location: {30, 40}, tower: true})
      target = tile_fixture(%{terrain: :plains})

      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      # 1 for air, 1 for tower, plus 3 original strength
      assert result.strength == 5
    end

    test "stack can be on a tile separate from the tower if connected" do
      units = [standard_fixture(%{access: :air, rank: 4, strength: 3})]
      stack = Warlords.UnitFixtures.stack_fixture(%{units: units})
      origin1 = tile_fixture(%{terrain: :hills, location: {30, 40}, tower: true})
      origin2 = tile_fixture(%{stack: stack, terrain: :hills, location: {30, 41}})
      target = tile_fixture(%{terrain: :plains})

      [result | _] =
        Formation.defense_formation([origin1, origin2], target, Warlords.Mock.Template)

      assert result.strength == 5
    end
  end

  describe "defense_formation/3 with a quest" do
    test "with no modifiers adds a point of strength" do
      unit = standard_fixture(%{access: :ground, rank: 4, strength: 3, strength_modifiers: %{}})
      stack = Warlords.UnitFixtures.stack_fixture(%{units: [unit]})

      origin =
        tile_fixture(%{stack: stack, terrain: :hills, location: {30, 40}, quest: :quest_rewards})

      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.strength == 4
    end

    test "increases the cap" do
      unit = standard_fixture(%{access: :ground, rank: 4, strength: 9, strength_modifiers: %{}})
      stack = Warlords.UnitFixtures.stack_fixture(%{units: [unit]})

      origin =
        tile_fixture(%{stack: stack, terrain: :hills, location: {30, 40}, quest: :quest_rewards})

      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      # Max was set to 9 in the mock template
      assert result.strength == 10
    end

    test "tower and stack bonuses stack" do
      units = [standard_fixture(%{access: :air, rank: 4, strength: 3})]
      stack = Warlords.UnitFixtures.stack_fixture(%{units: units})

      origin =
        tile_fixture(%{stack: stack, terrain: :hills, location: {30, 40}, quest: :quest_rewards})

      target = tile_fixture(%{terrain: :plains})

      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      # 1 for air, 1 for tower, plus 3 original strength
      assert result.strength == 5
    end

    test "stack can be on a tile separate from the quest if connected" do
      units = [standard_fixture(%{access: :air, rank: 4, strength: 3})]
      stack = Warlords.UnitFixtures.stack_fixture(%{units: units})
      origin1 = tile_fixture(%{terrain: :hills, location: {30, 40}, tower: true})
      origin2 = tile_fixture(%{stack: stack, terrain: :hills, location: {30, 41}})
      target = tile_fixture(%{terrain: :plains})

      [result | _] =
        Formation.defense_formation([origin1, origin2], target, Warlords.Mock.Template)

      assert result.strength == 5
    end
  end

  describe "defense_formation/3 with a city" do
    test "with no modifiers adds a point of strength" do
      unit = standard_fixture(%{access: :ground, rank: 4, strength: 3, strength_modifiers: %{}})
      stack = Warlords.UnitFixtures.stack_fixture(%{units: [unit]})

      origin =
        tile_fixture(%{
          stack: stack,
          terrain: :hills,
          location: {30, 40},
          city: city_fixture(%{level: 9})
        })

      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      assert result.strength == 6
    end

    test "increases the cap" do
      unit = standard_fixture(%{access: :ground, rank: 4, strength: 9, strength_modifiers: %{}})
      stack = Warlords.UnitFixtures.stack_fixture(%{units: [unit]})

      origin =
        tile_fixture(%{
          stack: stack,
          terrain: :hills,
          location: {30, 40},
          city: city_fixture(%{level: 9})
        })

      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      # Max was set to 9 in the mock template
      assert result.strength == 12
    end

    test "tower and stack bonuses stack" do
      units = [standard_fixture(%{access: :air, rank: 4, strength: 3})]
      stack = Warlords.UnitFixtures.stack_fixture(%{units: units})

      origin =
        tile_fixture(%{
          stack: stack,
          terrain: :hills,
          location: {30, 40},
          city: city_fixture(%{level: 9})
        })

      target = tile_fixture(%{terrain: :plains})

      [result | _] = Formation.defense_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      # 1 for air, 3 for the castle, plus 3 original strength
      assert result.strength == 7
    end

    test "stack can be on a tile separate from the city if connected" do
      units = [standard_fixture(%{access: :air, rank: 4, strength: 3})]
      stack = Warlords.UnitFixtures.stack_fixture(%{units: units})

      origin1 =
        tile_fixture(%{terrain: :hills, location: {30, 40}, city: city_fixture(%{level: 9})})

      origin2 = tile_fixture(%{stack: stack, terrain: :hills, location: {30, 41}})
      target = tile_fixture(%{terrain: :plains})

      [result | _] =
        Formation.defense_formation([origin1, origin2], target, Warlords.Mock.Template)

      assert result.strength == 7
    end
  end

  describe "defense_formation/3 with conected tiles" do
    test "stacks are combined and rank ordered" do
      unit1 = standard_fixture(%{access: :ground, rank: 1, strength: 3, strength_modifiers: %{}})
      origin1 = defense_formation_tile_fixture({30, 41}, :hills, [unit1])
      unit2 = standard_fixture(%{access: :ground, rank: 2, strength: 3, strength_modifiers: %{}})
      origin2 = defense_formation_tile_fixture({30, 42}, :hills, [unit2])
      unit3 = standard_fixture(%{access: :ground, rank: 3, strength: 3, strength_modifiers: %{}})
      origin3 = defense_formation_tile_fixture({30, 43}, :hills, [unit3])
      unit4 = standard_fixture(%{access: :ground, rank: 4, strength: 3, strength_modifiers: %{}})
      origin4 = defense_formation_tile_fixture({30, 44}, :hills, [unit4])
      target = tile_fixture(%{terrain: :plains})

      [result1, result2, result3, result4] =
        Formation.defense_formation(
          [origin4, origin1, origin3, origin2],
          target,
          Warlords.Mock.Template
        )

      assert result1.rank == 1
      assert result1.origin == {30, 41}
      assert result1.strength == 3
      assert result1.unit == unit1
      assert result2.rank == 2
      assert result2.origin == {30, 42}
      assert result2.strength == 3
      assert result2.unit == unit2
      assert result3.rank == 3
      assert result3.origin == {30, 43}
      assert result3.strength == 3
      assert result3.unit == unit3
      assert result4.rank == 4
      assert result4.origin == {30, 44}
      assert result4.strength == 3
      assert result4.unit == unit4
    end

    test "stack bonuses work across tiles" do
      unit1 = standard_fixture(%{access: :air, rank: 1, strength: 3, strength_modifiers: %{}})
      origin1 = defense_formation_tile_fixture({30, 41}, :hills, [unit1])
      unit2 = standard_fixture(%{access: :ground, rank: 2, strength: 3, strength_modifiers: %{}})
      origin2 = defense_formation_tile_fixture({30, 42}, :hills, [unit2])
      unit3 = standard_fixture(%{access: :ground, rank: 3, strength: 3, strength_modifiers: %{}})
      origin3 = defense_formation_tile_fixture({30, 43}, :hills, [unit3])
      unit4 = standard_fixture(%{access: :ground, rank: 4, strength: 3, strength_modifiers: %{}})
      origin4 = defense_formation_tile_fixture({30, 44}, :hills, [unit4])
      target = tile_fixture(%{terrain: :plains})

      [result1, result2, result3, result4] =
        Formation.defense_formation(
          [origin4, origin1, origin3, origin2],
          target,
          Warlords.Mock.Template
        )

      assert result1.strength == 4
      assert result2.strength == 4
      assert result3.strength == 4
      assert result4.strength == 4
    end
  end
end
