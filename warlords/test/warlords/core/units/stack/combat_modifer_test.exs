defmodule Warlords.Core.Units.Stack.CombatModiferTest do
  use Warlords.DataCase
  import Warlords.UnitFixtures
  alias Warlords.Core.Gameboard.Item
  alias Warlords.Core.Units
  alias Warlords.Core.Units.Stack
  alias Warlords.Core.Units.Stack.CombatModifier

  doctest CombatModifier

  @strength_item %Item{type: :strength, strength: 1}
  @small_item %Item{type: :leadership, strength: 2}
  @large_item %Item{type: :leadership, strength: 5}

  @small_hero hero_fixture(%{strength: 2})
  @medium_hero hero_fixture(%{strength: 5})
  @large_hero hero_fixture(%{strength: 7})
  @max_hero hero_fixture(%{strength: 9})
  @one_item_hero hero_fixture(%{strength: 2, items: [@strength_item, @small_item]})
  @two_item_hero hero_fixture(%{strength: 2, items: [@strength_item, @small_item, @large_item]})

  @flying_special special_fixture(%{army_type: :dragon, terrain_access: :air})
  @walking_special special_fixture(%{army_type: :ghost, terrain_access: :ground})
  @other_special special_fixture(%{army_type: :wizard, terrain_access: :ground})

  @flying_standard standard_fixture(%{terrain_access: :air})
  @walking_standard standard_fixture(%{terrain_access: :ground})

  test "Points max out at 9" do
    units = [
      @one_item_hero,
      @two_item_hero,
      @max_hero,
      @flying_special,
      @walking_special,
      @flying_standard,
      @walking_standard
    ]

    assert Units.combat_modifier(%Stack{units: units}) == 9
  end

  test "Points stack" do
    units = [
      @one_item_hero,
      @flying_special,
      @walking_special,
      @flying_standard,
      @walking_standard
    ]

    assert Units.combat_modifier(%Stack{units: units}) == 5
  end

  test "Flying points do not stack" do
    units = [@flying_standard, @flying_special]
    assert Units.combat_modifier(%Stack{units: units}) == 2
  end

  test "Special points stack" do
    units = [@walking_special, @walking_special, @other_special]
    assert Units.combat_modifier(%Stack{units: units}) == 2
  end

  test "Hero points stack" do
    units = [@small_hero, @medium_hero, @large_hero, @max_hero, @one_item_hero]
    assert Units.combat_modifier(%Stack{units: units}) == 8
  end

  test "small_hero result" do
    assert Units.combat_modifier(%Stack{units: [@small_hero]}) == 0
  end

  test "medium_hero result" do
    assert Units.combat_modifier(%Stack{units: [@medium_hero]}) == 1
  end

  test "large_hero result" do
    assert Units.combat_modifier(%Stack{units: [@large_hero]}) == 2
  end

  test "max_hero result" do
    assert Units.combat_modifier(%Stack{units: [@max_hero]}) == 3
  end

  test "one_item_hero result" do
    assert Units.combat_modifier(%Stack{units: [@one_item_hero]}) == 2
  end

  test "two_item_hero result" do
    assert Units.combat_modifier(%Stack{units: [@two_item_hero]}) == 7
  end

  test "flying_special result" do
    assert Units.combat_modifier(%Stack{units: [@flying_special]}) == 2
  end

  test "walking_special result" do
    assert Units.combat_modifier(%Stack{units: [@walking_special]}) == 1
  end

  test "flying_standard result" do
    assert Units.combat_modifier(%Stack{units: [@flying_standard]}) == 1
  end

  test "walking_standard result" do
    assert Units.combat_modifier(%Stack{units: [@walking_standard]}) == 0
  end
end
