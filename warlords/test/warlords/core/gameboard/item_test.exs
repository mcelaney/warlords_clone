defmodule Warlords.Core.Gameboard.ItemTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.Item

  doctest Item

  @valied_attrs %{id: :bow_of_eldros, label: "The Bow of Eldros", type: :strength, strength: 2}
  @required_fields ~w(id label type strength)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Item{} = result} = Gameboard.new_item(@valied_attrs)
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
      assert result.type == @valied_attrs[:type]
      assert result.strength == @valied_attrs[:strength]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_item(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_item(Map.delete(@valied_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "validates type is an expected value" do
      {:error, changeset} = Gameboard.new_item(Map.put(@valied_attrs, :type, :not_expected))
      assert "is invalid" in errors_on(changeset).type
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_item!(@valied_attrs)
      assert %Item{} = result
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
      assert result.type == @valied_attrs[:type]
      assert result.strength == @valied_attrs[:strength]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_item!(%{})
      end
    end
  end
end
