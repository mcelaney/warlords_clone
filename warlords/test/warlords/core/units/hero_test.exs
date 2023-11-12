defmodule Warlords.Core.Units.HeroTest do
  use Warlords.DataCase
  alias Warlords.Core.Units
  alias Warlords.Core.Units.Hero

  doctest Hero

  @valid_attrs %{label: "Brave Sir Robin", strength: 4, movement: 12, army_type: :hero}

  @required_fields ~w(label strength movement army_type)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Hero{} = result} = Units.new_hero(@valid_attrs)
      assert result.label == @valid_attrs[:label]
      assert result.strength == @valid_attrs[:strength]
      assert result.movement == @valid_attrs[:movement]
      assert result.army_type == @valid_attrs[:army_type]
      assert result.upkeep == 0
      assert result.terrain_access == :rider
      assert result.blessings == []
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Units.new_hero(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Hero.new(Map.delete(@valid_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Units.new_hero!(@valid_attrs)
      assert %Hero{} = result
      assert result.label == @valid_attrs[:label]
      assert result.strength == @valid_attrs[:strength]
      assert result.movement == @valid_attrs[:movement]
      assert result.army_type == @valid_attrs[:army_type]
      assert result.upkeep == 0
      assert result.terrain_access == :rider
      assert result.blessings == []
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Units.new_hero!(%{})
      end
    end
  end
end
