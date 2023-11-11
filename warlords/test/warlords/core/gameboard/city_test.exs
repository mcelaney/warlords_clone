defmodule Warlords.Core.Gameboard.CityTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.ArmyTemplate
  alias Warlords.Core.Gameboard.City

  doctest City

  @valid_attrs %{
    id: :ak_enlie,
    label: "Ak-enlie",
    defense: 4,
    army_templates: [
      ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8})
    ]
  }
  @required_fields ~w(id label defense)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %City{} = result} = Gameboard.new_city(@valid_attrs)
      assert result.id == @valid_attrs[:id]
      assert result.label == @valid_attrs[:label]
      assert result.defense == @valid_attrs[:defense]
      assert result.army_templates == @valid_attrs[:army_templates]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Gameboard.new_city(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Gameboard.new_city(Map.delete(@valid_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "does not require capital" do
      {:ok, %City{} = result} = Gameboard.new_city(Map.delete(@valid_attrs, :capital))
      assert is_nil(result.capital)
    end

    test "will accept an empire id for capital" do
      {:ok, %City{} = result} =
        Gameboard.new_city(Map.put(@valid_attrs, :capital, :storm_giants))

      assert result.capital == :storm_giants
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Gameboard.new_city!(@valid_attrs)
      assert %City{} = result
      assert result.id == @valid_attrs[:id]
      assert result.label == @valid_attrs[:label]
      assert result.defense == @valid_attrs[:defense]
      assert result.army_templates == @valid_attrs[:army_templates]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Gameboard.new_city!(%{})
      end
    end
  end
end
