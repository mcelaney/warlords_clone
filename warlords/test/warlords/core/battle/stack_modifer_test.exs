defmodule Warlords.Core.Battle.StackModifierTest do
  use ExUnit.Case, async: true
  import Warlords.GameboardFixtures
  import Warlords.UnitFixtures
  alias Warlords.Core.Battle.StackModifier

  doctest StackModifier

  test "walking_standard has no leadership" do
    units = [standard_fixture(%{access: :ground})]
    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 0
  end

  test "one leadership if any flying" do
    units = [
      standard_fixture(%{production_key: :bats, access: :air}),
      standard_fixture(%{production_key: :eagles, access: :air})
    ]

    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 1

    units = [
      special_fixture(%{production_key: :bats, access: :air}),
      special_fixture(%{production_key: :eagles, access: :air})
    ]

    # One point for each special plus a point because they fly
    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 3
  end

  test "one leadership for each type of special ground unit" do
    units = [
      special_fixture(%{production_key: :wizard, access: :ground})
    ]

    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 1

    units = [
      special_fixture(%{production_key: :wizard, access: :ground}),
      special_fixture(%{production_key: :ghost, access: :ground})
    ]

    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 2

    units = [
      special_fixture(%{production_key: :wizard, access: :ground}),
      special_fixture(%{production_key: :wizard, access: :ground}),
      special_fixture(%{production_key: :ghost, access: :ground}),
      special_fixture(%{production_key: :ghost, access: :ground})
    ]

    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 2
  end

  test "leadership points stack" do
    artifacts = [artifact_fixture(%{leadership: 2})]

    units = [
      # 1 point
      standard_fixture(%{production_key: :bats, access: :air}),
      # 1 point
      special_fixture(%{production_key: :wizard, access: :ground}),
      # 2 points
      special_fixture(%{production_key: :dragon, access: :air}),
      # 3 points
      hero_fixture(%{strength: 5, artifacts: artifacts})
    ]

    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 7
  end

  test "flying and special points stack" do
    units = [
      special_fixture(%{production_key: :dragon, access: :air})
    ]

    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 2

    units = [
      special_fixture(%{production_key: :dragon, access: :air}),
      special_fixture(%{production_key: :eagle, access: :air})
    ]

    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 3

    units = [
      special_fixture(%{production_key: :dragon, access: :air}),
      special_fixture(%{production_key: :dragon, access: :air}),
      special_fixture(%{production_key: :eagle, access: :air}),
      special_fixture(%{production_key: :eagle, access: :air})
    ]

    assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 3
  end

  describe "heros" do
    test "weak heros have no effect" do
      0..3
      |> Enum.each(fn strength ->
        hero = hero_fixture(%{strength: strength})
        assert StackModifier.stack_bonus(stack_fixture(%{units: [hero]})) == 0
      end)
    end

    test "normal heros have effect" do
      4..6
      |> Enum.each(fn strength ->
        hero = hero_fixture(%{strength: strength})
        assert StackModifier.stack_bonus(stack_fixture(%{units: [hero]})) == 1
      end)
    end

    test "strong heros have effect" do
      7..8
      |> Enum.each(fn strength ->
        hero = hero_fixture(%{strength: strength})
        assert StackModifier.stack_bonus(stack_fixture(%{units: [hero]})) == 2
      end)
    end

    test "max heros have effect" do
      hero = hero_fixture(%{strength: 9})
      assert StackModifier.stack_bonus(stack_fixture(%{units: [hero]})) == 3
    end

    test "hero strength is affected by flying units before assessed" do
      hero = hero_fixture(%{strength: 3})
      units = [hero_fixture(%{strength: 1})]
      assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 0

      units = [hero, standard_fixture(%{access: :air})]
      assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 2
    end

    test "hero strength is affected by special units before assessed" do
      hero = hero_fixture(%{strength: 3})
      units = [hero_fixture(%{strength: 1})]
      assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 0

      units = [hero, special_fixture(%{access: :ground})]
      # one for special, one for hero strength 4
      assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 2

      hero = hero_fixture(%{strength: 2})
      units = [hero, special_fixture(%{access: :air})]
      # one for flying, one for special, one for hero strength 4
      assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 3
    end

    test "strength artificts have no effect" do
      artifacts = [artifact_fixture(%{strength: 1, leadership: 0})]
      hero = hero_fixture(%{strength: 1, artifacts: artifacts})
      assert StackModifier.stack_bonus(stack_fixture(%{units: [hero]})) == 0
    end

    test "leadership artifacts stack" do
      artifacts = [artifact_fixture(%{leadership: 1})]
      hero = hero_fixture(%{strength: 1, artifacts: artifacts})
      assert StackModifier.stack_bonus(stack_fixture(%{units: [hero]})) == 1

      artifacts = [artifact_fixture(%{leadership: 5})]
      hero = hero_fixture(%{strength: 1, artifacts: artifacts})
      assert StackModifier.stack_bonus(stack_fixture(%{units: [hero]})) == 5

      artifacts = [artifact_fixture(%{leadership: 1}), artifact_fixture(%{leadership: 1})]
      hero = hero_fixture(%{strength: 1, artifacts: artifacts})
      assert StackModifier.stack_bonus(stack_fixture(%{units: [hero]})) == 2
    end

    test "Hero points stack" do
      units = [
        hero_fixture(%{strength: 5}),
        hero_fixture(%{strength: 5})
      ]

      assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 2

      artifacts = [artifact_fixture(%{leadership: 1})]

      units = [
        hero_fixture(%{strength: 5, artifacts: artifacts}),
        hero_fixture(%{strength: 5, artifacts: artifacts})
      ]

      assert StackModifier.stack_bonus(stack_fixture(%{units: units})) == 4
    end
  end
end
