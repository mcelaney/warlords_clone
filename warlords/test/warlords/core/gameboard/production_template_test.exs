defmodule Warlords.Core.Gameboard.ProductionTemplateTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.ProductionTemplate

  doctest ProductionTemplate

  @valid_attrs %{type: :archers, time: 3, cost: 4, strength: 4, movement: 12}
  @required_fields ~w(type time cost strength movement)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %ProductionTemplate{} = result} = Gameboard.new_army_template(@valid_attrs)
      assert result.type == @valid_attrs[:type]
      assert result.time == @valid_attrs[:time]
      assert result.cost == @valid_attrs[:cost]
      assert result.strength == @valid_attrs[:strength]
      assert result.movement == @valid_attrs[:movement]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_army_template(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_army_template(Map.delete(@valid_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "validates cost is an even number" do
      {:error, changeset} = Gameboard.new_army_template(Map.put(@valid_attrs, :cost, 3))
      assert "must be an even number" in errors_on(changeset).cost
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_army_template!(@valid_attrs)
      assert %ProductionTemplate{} = result
      assert result.type == @valid_attrs[:type]
      assert result.time == @valid_attrs[:time]
      assert result.cost == @valid_attrs[:cost]
      assert result.strength == @valid_attrs[:strength]
      assert result.movement == @valid_attrs[:movement]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_army_template!(%{})
      end
    end
  end
end
