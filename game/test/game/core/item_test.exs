defmodule Game.Core.ItemTest do
  use Game.DataCase
  alias Game.Core.Item

  doctest Item

  @valied_attrs %{id: :bow_of_eldros, label: "The Bow of Eldros", type: :strength, strength: 2}
  @required_fields ~w(id label type strength)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Item{} = result} = Item.new(@valied_attrs)
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
      assert result.type == @valied_attrs[:type]
      assert result.strength == @valied_attrs[:strength]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Item.new(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Item.new(Map.delete(@valied_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "validates type is an expected value" do
      {:error, changeset} = Item.new(Map.put(@valied_attrs, :type, :not_expected))
      assert "is invalid" in errors_on(changeset).type
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Item.new!(@valied_attrs)
      assert %Item{} = result
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
      assert result.type == @valied_attrs[:type]
      assert result.strength == @valied_attrs[:strength]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Item.new!(%{})
      end
    end
  end
end
