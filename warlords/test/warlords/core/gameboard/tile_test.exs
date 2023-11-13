defmodule Warlords.Core.Gameboard.TileTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.Tile

  # doctest Tile

  @terrain %Warlords.Core.Gameboard.Terrain{id: :hill, type: :ground}
  @valid_attrs %{
    x: 50,
    y: 100,
    terrain: @terrain,
    connected: [{50, 100}, {50, 101}, {51, 100}, {51, 101}]
  }
  @required_fields ~w(x y terrain)a

  describe "add_stack/2" do
    test "adds a stack to the tile" do
      tile = %Warlords.Core.Gameboard.Tile{
        x: 50,
        y: 100,
        terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land}
      }

      stack = %Warlords.Core.Units.Stack{
        units: [
          %Warlords.Core.Units.Standard{
            label: "Gildenhome 2nd Elven Archers",
            strength: 4,
            movement: 12,
            upkeep: 2,
            army_type: :archer,
            terrain_access: :ground
          }
        ]
      }

      {:ok, tile} = Gameboard.add_stack_to_tile(tile, stack)
      assert stack == tile.stack
    end

    test "merges stacks if one already exists on the tile" do
      tile = %Warlords.Core.Gameboard.Tile{
        x: 50,
        y: 100,
        terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land},
        stack: %Warlords.Core.Units.Stack{
          units: [
            %Warlords.Core.Units.Standard{
              label: "Gildenhome 1st Elven Archers",
              strength: 4,
              movement: 12,
              upkeep: 2,
              army_type: :archer,
              terrain_access: :ground
            }
          ]
        }
      }

      stack = %Warlords.Core.Units.Stack{
        units: [
          %Warlords.Core.Units.Standard{
            label: "Gildenhome 2nd Elven Archers",
            strength: 4,
            movement: 12,
            upkeep: 2,
            army_type: :archer,
            terrain_access: :ground
          }
        ]
      }

      {:ok, tile} = Gameboard.add_stack_to_tile(tile, stack)
      assert Enum.count(tile.stack.units) == 2
      result = Enum.map(tile.stack.units, fn %{label: label} -> label end)
      ["Gildenhome 1st Elven Archers", "Gildenhome 2nd Elven Archers"] = result
    end

    test "errors if the tile belongs to another player" do
      tile = %Warlords.Core.Gameboard.Tile{
        x: 50,
        y: 100,
        terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land},
        stack: %Warlords.Core.Units.Stack{
          empire_id: :elves,
          units: [
            %Warlords.Core.Units.Standard{
              label: "Gildenhome 1st Elven Archers",
              strength: 4,
              movement: 12,
              upkeep: 2,
              army_type: :archer,
              terrain_access: :ground
            }
          ]
        }
      }

      stack = %Warlords.Core.Units.Stack{
        empire_id: :storm,
        units: [
          %Warlords.Core.Units.Standard{
            label: "Gildenhome 2nd Elven Archers",
            strength: 4,
            movement: 12,
            upkeep: 2,
            army_type: :archer,
            terrain_access: :ground
          }
        ]
      }

      {:error, message} = Gameboard.add_stack_to_tile(tile, stack)
      assert message == "Stack belongs to another player"
    end

    test "errors if the tile is full" do
      tile = %Warlords.Core.Gameboard.Tile{
        x: 50,
        y: 100,
        terrain: %Warlords.Core.Gameboard.Terrain{id: :hill, type: :land},
        stack: %Warlords.Core.Units.Stack{
          units: [
            %Warlords.Core.Units.Standard{label: "Gildenhome 1"},
            %Warlords.Core.Units.Standard{label: "Gildenhome 2"},
            %Warlords.Core.Units.Standard{label: "Gildenhome 3"},
            %Warlords.Core.Units.Standard{label: "Gildenhome 4"},
            %Warlords.Core.Units.Standard{label: "Gildenhome 5"},
            %Warlords.Core.Units.Standard{label: "Gildenhome 6"},
            %Warlords.Core.Units.Standard{label: "Gildenhome 7"},
            %Warlords.Core.Units.Standard{label: "Gildenhome 8"}
          ]
        }
      }

      stack = %Warlords.Core.Units.Stack{
        units: [%Warlords.Core.Units.Standard{label: "Gildenhome 9"}]
      }

      {:error, message} = Gameboard.add_stack_to_tile(tile, stack)
      assert message == "Stack can only have up to 8 units"
    end
  end

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Tile{} = result} = Gameboard.new_tile(@valid_attrs)
      assert result.x == @valid_attrs[:x]
      assert result.y == @valid_attrs[:y]
      assert result.terrain == @valid_attrs[:terrain]
      assert result.connected == @valid_attrs[:connected]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_tile(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_tile(Map.delete(@valid_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_tile!(@valid_attrs)
      assert %Tile{} = result
      assert result.x == @valid_attrs[:x]
      assert result.y == @valid_attrs[:y]
      assert result.terrain == @valid_attrs[:terrain]
      assert result.connected == @valid_attrs[:connected]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_tile!(%{})
      end
    end
  end
end
