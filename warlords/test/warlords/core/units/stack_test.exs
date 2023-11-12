defmodule Warlords.Core.Units.StackTest do
  use Warlords.DataCase
  alias Warlords.Core.Units
  alias Warlords.Core.Units.Stack

  doctest Stack

  @units [
    %Warlords.Core.Units.Hero{
      label: "Brave Sir Robin",
      strength: 5,
      movement: 12,
      upkeep: 0,
      army_type: :hero,
      terrain_access: :rider,
      blessings: []
    },
    %Warlords.Core.Units.Special{
      label: "Undead",
      strength: 6,
      movement: 10,
      upkeep: 0,
      army_type: :ghost,
      terrain_access: :ground,
      blessings: []
    },
    %Warlords.Core.Units.Special{
      label: "Dragons",
      strength: 7,
      movement: 16,
      upkeep: 0,
      army_type: :dragon,
      terrain_access: :air,
      blessings: []
    },
    %Warlords.Core.Units.Standard{
      label: "Gildenhome 1st Elven Archers",
      strength: 4,
      movement: 12,
      upkeep: 2,
      army_type: :archer,
      terrain_access: :ground,
      blessings: []
    },
    %Warlords.Core.Units.Standard{
      label: "Gildenhome 2nd Elven Archers",
      strength: 4,
      movement: 12,
      upkeep: 2,
      army_type: :archer,
      terrain_access: :ground,
      blessings: []
    },
    %Warlords.Core.Units.Standard{
      label: "Gildenhome 3rd Elven Archers",
      strength: 4,
      movement: 12,
      upkeep: 2,
      army_type: :archer,
      terrain_access: :ground,
      blessings: []
    },
    %Warlords.Core.Units.Standard{
      label: "Gildenhome 4th Elven Archers",
      strength: 4,
      movement: 12,
      upkeep: 2,
      army_type: :archer,
      terrain_access: :ground,
      blessings: []
    },
    %Warlords.Core.Units.Standard{
      label: "Gildenhome 5th Elven Archers",
      strength: 4,
      movement: 12,
      upkeep: 2,
      army_type: :archer,
      terrain_access: :ground,
      blessings: []
    }
  ]

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Stack{} = result} = Units.new_stack(%{units: @units})
      assert Enum.count(result.units) == 8
    end

    test "limits to 8 units" do
      units = [
        %Warlords.Core.Units.Standard{
          label: "Gildenhome 6th Elven Archers",
          strength: 4,
          movement: 12,
          upkeep: 2,
          army_type: :archer,
          terrain_access: :ground,
          blessings: []
        }
        | @units
      ]

      {:error, changeset} = Units.new_stack(%{units: units})
      assert %{units: ["Stack can only have up to 8 units"]} == errors_on(changeset)
    end

    test "requires one unit" do
      {:error, changeset} = Units.new_stack(%{units: []})
      assert %{units: ["Stack must have at least one unit"]} == errors_on(changeset)
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      %Stack{} = result = Units.new_stack!(%{units: @units})
      assert Enum.count(result.units) == 8
    end

    test "limits to 8 units" do
      units = [
        %Warlords.Core.Units.Standard{
          label: "Gildenhome 6th Elven Archers",
          strength: 4,
          movement: 12,
          upkeep: 2,
          army_type: :archer,
          terrain_access: :ground,
          blessings: []
        }
        | @units
      ]

      assert_raise RuntimeError, fn ->
        Units.new_stack!(%{units: units})
      end
    end

    test "requires one unit" do
      assert_raise RuntimeError, fn ->
        Units.new_stack!(%{units: []})
      end
    end
  end
end
