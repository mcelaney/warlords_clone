defmodule Warlords.Core.Gameboard.EmpireTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.Empire

  doctest Empire

  @valid_attrs %{id: :horse_lords, label: "Horse Lords"}
  @required_fields ~w(id label)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Empire{} = result} = Gameboard.new_empire(@valid_attrs)
      assert result.id == @valid_attrs[:id]
      assert result.label == @valid_attrs[:label]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_empire(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_empire(Map.delete(@valid_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_empire!(@valid_attrs)
      assert %Empire{} = result
      assert result.id == @valid_attrs[:id]
      assert result.label == @valid_attrs[:label]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_empire!(%{})
      end
    end
  end
end
