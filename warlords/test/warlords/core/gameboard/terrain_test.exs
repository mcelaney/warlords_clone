defmodule Warlords.Core.Gameboard.TerrainTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.Terrain

  doctest Terrain

  @valid_attrs %{id: :road, type: :land}
  @required_fields ~w(id type)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Terrain{} = result} = Gameboard.new_terrain(@valid_attrs)
      assert result.id == @valid_attrs[:id]
      assert result.type == @valid_attrs[:type]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_terrain(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_terrain(Map.delete(@valid_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "validates type is an expected value" do
      {:error, changeset} = Gameboard.new_terrain(Map.put(@valid_attrs, :type, :not_expected))
      assert "is invalid" in errors_on(changeset).type
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_terrain!(@valid_attrs)
      assert %Terrain{} = result
      assert result.id == @valid_attrs[:id]
      assert result.type == @valid_attrs[:type]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_terrain!(%{})
      end
    end
  end
end
