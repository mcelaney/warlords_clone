defmodule Warlords.Core.Gameboard.ArmyTemplateTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.ArmyTemplate

  doctest ArmyTemplate

  @valied_attrs %{type: :archers, time: 3, cost: 4, strength: 4, movement: 12}
  @required_fields ~w(type time cost strength movement)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %ArmyTemplate{} = result} = Gameboard.new_army_template(@valied_attrs)
      assert result.type == @valied_attrs[:type]
      assert result.time == @valied_attrs[:time]
      assert result.cost == @valied_attrs[:cost]
      assert result.strength == @valied_attrs[:strength]
      assert result.movement == @valied_attrs[:movement]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_army_template(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_army_template(Map.delete(@valied_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "validates cost is an even number" do
      {:error, changeset} = Gameboard.new_army_template(Map.put(@valied_attrs, :cost, 3))
      assert "must be an even number" in errors_on(changeset).cost
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_army_template!(@valied_attrs)
      assert %ArmyTemplate{} = result
      assert result.type == @valied_attrs[:type]
      assert result.time == @valied_attrs[:time]
      assert result.cost == @valied_attrs[:cost]
      assert result.strength == @valied_attrs[:strength]
      assert result.movement == @valied_attrs[:movement]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_army_template!(%{})
      end
    end
  end
end
