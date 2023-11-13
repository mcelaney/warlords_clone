defmodule Warlords.Core.Gameboard.TerrainTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.Terrain

  doctest Terrain

  @valid_attrs %{
    id: :road,
    type: :land,
    combat_modifiers: %{
      elvallie: 0,
      grey_dwarves: 0,
      horse_lords: 0,
      lord_bane: 0,
      orcs_of_kor: 0,
      selentines: 0,
      sirians: 0,
      storm_giants: 0
    }
  }
  @required_fields ~w(id type combat_modifiers)a

  describe "combat_modifier/1" do
    test "finds for a defending stack on a tile" do
      tile = %Warlords.Core.Gameboard.Tile{
        terrain: %Warlords.Core.Gameboard.Terrain{
          id: :hill,
          type: :land,
          combat_modifiers: %{elvallie: 1}
        },
        stack: %Warlords.Core.Units.Stack{empire_id: :elvallie}
      }

      assert Warlords.Core.Gameboard.Terrain.combat_modifier(tile) == 1
    end
  end

  describe "combat_modifier/2" do
    test "returns 0 if there is no defender" do
      tile = %Warlords.Core.Gameboard.Tile{
        terrain: %Warlords.Core.Gameboard.Terrain{
          id: :hill,
          type: :land,
          combat_modifiers: %{elvallie: 1}
        }
      }

      assert Warlords.Core.Gameboard.Terrain.combat_modifier(tile) == 0
    end

    test "finds for tile given an attacking stack" do
      tile = %Warlords.Core.Gameboard.Tile{
        terrain: %Warlords.Core.Gameboard.Terrain{
          id: :hill,
          type: :land,
          combat_modifiers: %{elvallie: 2}
        }
      }

      assert Warlords.Core.Gameboard.Terrain.combat_modifier(tile, %Warlords.Core.Units.Stack{
               empire_id: :elvallie
             }) == 2
    end

    test "finds for tile given an attacking empire_id" do
      tile = %Warlords.Core.Gameboard.Tile{
        terrain: %Warlords.Core.Gameboard.Terrain{
          id: :hill,
          type: :land,
          combat_modifiers: %{elvallie: 2}
        }
      }

      assert Warlords.Core.Gameboard.Terrain.combat_modifier(tile, :elvallie) == 2
    end

    test "finds for terrain given an attacking stack" do
      terrain = %Warlords.Core.Gameboard.Terrain{
        id: :hill,
        type: :land,
        combat_modifiers: %{elvallie: 2}
      }

      assert Warlords.Core.Gameboard.Terrain.combat_modifier(terrain, %Warlords.Core.Units.Stack{
               empire_id: :elvallie
             }) == 2
    end

    test "finds for terrain given an attacking empire_id" do
      terrain = %Warlords.Core.Gameboard.Terrain{
        id: :hill,
        type: :land,
        combat_modifiers: %{elvallie: 3}
      }

      assert Warlords.Core.Gameboard.Terrain.combat_modifier(terrain, :elvallie) == 3
    end
  end

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Terrain{} = result} = Gameboard.new_terrain(@valid_attrs)
      assert result.id == @valid_attrs[:id]
      assert result.type == @valid_attrs[:type]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_terrain(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_terrain(Map.delete(@valid_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "validates type is an expected value" do
      {:error, changeset} = Gameboard.new_terrain(Map.put(@valid_attrs, :type, :not_expected))
      assert "is invalid" in errors_on(changeset).type
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_terrain!(@valid_attrs)
      assert %Terrain{} = result
      assert result.id == @valid_attrs[:id]
      assert result.type == @valid_attrs[:type]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_terrain!(%{})
      end
    end
  end
end
