defmodule Warlords.Core.Battle.Formation.AttackTest do
  use ExUnit.Case, async: true

  import Warlords.GameboardFixtures
  import Warlords.UnitFixtures
  alias Warlords.Core.Battle.Formation

  describe "attack_formation/3" do
    test "with no modifiers" do
      unit = standard_fixture(%{access: :ground, rank: 4, strength: 3, strength_modifiers: %{}})
      origin = attack_formation_tile_fixture({30, 40}, :hills, [unit])
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.attack_formation(origin, target, Warlords.Mock.Template)
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

      origin = attack_formation_tile_fixture({30, 40}, :hills, units)
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.attack_formation(origin, target, Warlords.Mock.Template)
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

      origin = attack_formation_tile_fixture({30, 40}, :hills, units)
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.attack_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      assert result.strength == 2
    end

    test "caps strength" do
      units = [
        standard_fixture(%{access: :ground, rank: 4, strength: 10, strength_modifiers: %{}})
      ]

      origin = attack_formation_tile_fixture({30, 40}, :hills, units)
      target = tile_fixture(%{terrain: :plains})
      [result | _] = Formation.attack_formation(origin, target, Warlords.Mock.Template)
      assert result.rank == 4
      assert result.origin == {30, 40}
      # Max was set to 9 in the mock template
      assert result.strength == 9
    end

    test "terrain and stack bonuses stack" do
      units = [
        standard_fixture(%{access: :air, rank: 4, strength: 3, strength_modifiers: %{plains: 1}})
      ]

      origin = attack_formation_tile_fixture({30, 40}, :hills, units)
      target = tile_fixture(%{terrain: :plains})

      [result | _] = Formation.attack_formation(origin, target, Warlords.Mock.Template)
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
      origin = attack_formation_tile_fixture({30, 40}, :hills, [unit4, unit3, unit1, unit2])
      target = tile_fixture()

      [%{unit: res1}, %{unit: res2}, %{unit: res3}, %{unit: res4}] =
        Formation.attack_formation(origin, target, Warlords.Mock.Template)

      assert res1.rank == 1
      assert res2.rank == 2
      assert res3.rank == 3
      assert res4.rank == 4
    end
  end
end
