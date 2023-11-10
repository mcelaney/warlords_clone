defmodule Warlords.Core.Gameboard.ArmyTypeTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.ArmyType

  doctest ArmyType

  @valied_attrs %{id: :dragon, label: "Dragons", type: :special, access: :air}
  @required_fields ~w(id label type access)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %ArmyType{} = result} = Gameboard.new_army_type(@valied_attrs)
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
      assert result.type == @valied_attrs[:type]
      assert result.access == @valied_attrs[:access]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_army_type(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_army_type(Map.delete(@valied_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "validates type is an expected value" do
      {:error, changeset} = Gameboard.new_army_type(Map.put(@valied_attrs, :type, :not_expected))
      assert "is invalid" in errors_on(changeset).type
    end

    test "validates access is an expected value" do
      {:error, changeset} =
        Gameboard.new_army_type(Map.put(@valied_attrs, :access, :not_expected))

      assert "is invalid" in errors_on(changeset).access
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_army_type!(@valied_attrs)
      assert %ArmyType{} = result
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
      assert result.type == @valied_attrs[:type]
      assert result.access == @valied_attrs[:access]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_army_type!(%{})
      end
    end
  end
end
