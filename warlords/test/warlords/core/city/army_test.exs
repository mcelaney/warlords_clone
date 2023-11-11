defmodule Warlords.Core.City.ArmyTest do
  use Warlords.DataCase
  alias Warlords.Core.City
  alias Warlords.Core.City.Army

  doctest Army

  @valid_attrs %{
    city: "Gildenhome",
    nth: 101,
    strength: 4,
    movement: 12,
    upkeep: 2,
    type: %Warlords.Core.Gameboard.ArmyType{
      id: :archer,
      label: "Elven Archers",
      type: :standard,
      access: :groud
    }
  }

  @required_fields ~w(city nth strength movement upkeep)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Army{} = result} = City.produce_army(@valid_attrs)
      assert result.label == "Gildenhome 101st Elven Archers"
      assert result.strength == @valid_attrs[:strength]
      assert result.movement == @valid_attrs[:movement]
      assert result.upkeep == @valid_attrs[:upkeep]
      assert result.army_type == @valid_attrs[:type].id
      assert result.terrain_access == @valid_attrs[:type].access
      assert result.blessings == []
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = City.produce_army(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = City.produce_army(Map.delete(@valid_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "requires a valid army type" do
      {:error, changeset} =
        City.produce_army(Map.delete(@valid_attrs, :type))

      assert "can't be blank" in errors_on(changeset).type
    end

    test "resuires type to be an ArmyType" do
      {:error, changeset} =
        City.produce_army(Map.put(@valid_attrs, :type, :archer))

      assert "must be an ArmyType" in errors_on(changeset).type
    end

    test "will ignore blessings" do
      {:ok, result} =
        @valid_attrs
        |> Map.put(:blessings, ["ignored"])
        |> City.produce_army()

      assert Enum.empty?(result.blessings)
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = City.produce_army!(@valid_attrs)
      assert %Army{} = result
      assert result.label == "Gildenhome 101st Elven Archers"
      assert result.strength == @valid_attrs[:strength]
      assert result.movement == @valid_attrs[:movement]
      assert result.upkeep == @valid_attrs[:upkeep]
      assert result.army_type == @valid_attrs[:type].id
      assert result.terrain_access == @valid_attrs[:type].access
      assert result.blessings == []
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        City.produce_army!(%{})
      end
    end
  end
end
