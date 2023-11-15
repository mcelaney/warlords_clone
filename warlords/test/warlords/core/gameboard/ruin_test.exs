defmodule Warlords.Core.Gameboard.RuinTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.Ruin

  doctest Ruin

  @valid_temple_attrs %{type: :temple, gold: 5000}
  @valid_ruin_attrs %{
    type: :ruin,
    stack: %Warlords.Core.Units.Stack{
      units: [
        %Warlords.Core.Units.Special{
          label: "Undead",
          strength: 4,
          movement: 12,
          upkeep: 0,
          army_type: :ghost,
          terrain_access: :ground
        }
      ]
    },
    units: [
      %Warlords.Core.Units.Special{
        label: "Dragon",
        army_type: :dragon,
        strength: 9,
        movement: 24,
        terrain_access: :air
      }
    ]
  }
  @valid_tomb_attrs %{
    type: :tomb,
    stack: %Warlords.Core.Units.Stack{
      units: [
        %Warlords.Core.Units.Special{
          label: "Undead",
          strength: 4,
          movement: 12,
          upkeep: 0,
          army_type: :ghost,
          terrain_access: :ground
        }
      ]
    },
    item: %Warlords.Core.Gameboard.Item{
      id: :firesword,
      label: "The Firesword",
      type: :strength,
      strength: 2
    }
  }
  @valid_dungeon_attrs %{
    type: :dungeon,
    stack: %Warlords.Core.Units.Stack{
      units: [
        %Warlords.Core.Units.Special{
          label: "Undead",
          strength: 4,
          movement: 12,
          upkeep: 0,
          army_type: :ghost,
          terrain_access: :ground
        }
      ]
    },
    gold: 8000
  }

  @required_fields ~w(type)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Ruin{} = result} = Gameboard.new_ruin(@valid_temple_attrs)
      assert result.type == @valid_temple_attrs[:type]
      assert result.gold == @valid_temple_attrs[:gold]
      assert result.stack == nil
      assert result.units == []
      assert result.item == nil
      assert result.defense == 1
    end

    test "with a defending stack and units as prize" do
      {:ok, %Ruin{} = result} = Gameboard.new_ruin(@valid_ruin_attrs)
      assert result.type == @valid_ruin_attrs[:type]
      assert result.gold == nil
      assert result.stack == @valid_ruin_attrs[:stack]
      assert result.units == @valid_ruin_attrs[:units]
      assert result.item == nil
      assert result.defense == 1
    end

    test "with a defending stack and item as prize" do
      {:ok, %Ruin{} = result} = Gameboard.new_ruin(@valid_tomb_attrs)
      assert result.type == @valid_tomb_attrs[:type]
      assert result.gold == nil
      assert result.stack == @valid_tomb_attrs[:stack]
      assert result.units == []
      assert result.item == @valid_tomb_attrs[:item]
      assert result.defense == 1
    end

    test "with a defending stack and gold as prize" do
      {:ok, %Ruin{} = result} = Gameboard.new_ruin(@valid_dungeon_attrs)
      assert result.type == @valid_dungeon_attrs[:type]
      assert result.gold == @valid_dungeon_attrs[:gold]
      assert result.stack == @valid_dungeon_attrs[:stack]
      assert result.units == []
      assert result.item == nil
      assert result.defense == 1
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_ruin(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_ruin(Map.delete(@valid_temple_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "validates type is an expected value" do
      {:error, changeset} = Gameboard.new_ruin(Map.put(@valid_temple_attrs, :type, :not_expected))
      assert "is invalid" in errors_on(changeset).type
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_ruin!(@valid_temple_attrs)
      assert result.type == @valid_temple_attrs[:type]
      assert result.gold == @valid_temple_attrs[:gold]
      assert result.stack == nil
      assert result.units == []
      assert result.item == nil
      assert result.defense == 1
    end

    test "with a defending stack and units as prize" do
      result = Gameboard.new_ruin!(@valid_ruin_attrs)
      assert result.type == @valid_ruin_attrs[:type]
      assert result.gold == nil
      assert result.stack == @valid_ruin_attrs[:stack]
      assert result.units == @valid_ruin_attrs[:units]
      assert result.item == nil
      assert result.defense == 1
    end

    test "with a defending stack and item as prize" do
      %Ruin{} = result = Gameboard.new_ruin!(@valid_tomb_attrs)
      assert result.type == @valid_tomb_attrs[:type]
      assert result.gold == nil
      assert result.stack == @valid_tomb_attrs[:stack]
      assert result.units == []
      assert result.item == @valid_tomb_attrs[:item]
      assert result.defense == 1
    end

    test "with a defending stack and gold as prize" do
      %Ruin{} = result = Gameboard.new_ruin!(@valid_dungeon_attrs)
      assert result.type == @valid_dungeon_attrs[:type]
      assert result.gold == @valid_dungeon_attrs[:gold]
      assert result.stack == @valid_dungeon_attrs[:stack]
      assert result.units == []
      assert result.item == nil
      assert result.defense == 1
    end

    test "with invalid attributes returns an changeset" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_ruin!(%{})
      end
    end
  end
end
