defmodule Warlords.Core.Units.StandardTest do
  use Warlords.DataCase
  alias Warlords.Core.Units
  alias Warlords.Core.Units.Standard

  doctest Standard

  @valid_attrs %{
    label: "Dragons",
    strength: 4,
    movement: 12,
    army_type: :dragon,
    terrain_access: :air,
    upkeep: 4
  }

  @required_fields ~w(label strength movement army_type)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Standard{} = result} = Units.new_unit(@valid_attrs)
      assert result.label == @valid_attrs[:label]
      assert result.strength == @valid_attrs[:strength]
      assert result.movement == @valid_attrs[:movement]
      assert result.army_type == @valid_attrs[:army_type]
      assert result.terrain_access == @valid_attrs[:terrain_access]
      assert result.upkeep == 4
      assert result.blessings == []
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Units.new_unit(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Units.new_unit(Map.delete(@valid_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Units.new_unit!(@valid_attrs)
      assert %Standard{} = result
      assert result.label == @valid_attrs[:label]
      assert result.strength == @valid_attrs[:strength]
      assert result.movement == @valid_attrs[:movement]
      assert result.army_type == @valid_attrs[:army_type]
      assert result.terrain_access == @valid_attrs[:terrain_access]
      assert result.upkeep == 4
      assert result.blessings == []
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Units.new_unit!(%{})
      end
    end
  end
end
