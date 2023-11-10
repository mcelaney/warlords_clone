defmodule Game.Core.CityTest do
  use Game.DataCase
  alias Game.Core.ArmyTemplate
  alias Game.Core.City

  doctest City

  @valied_attrs %{
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
      {:ok, %City{} = result} = City.new(@valied_attrs)
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
      assert result.defense == @valied_attrs[:defense]
      assert result.army_templates == @valied_attrs[:army_templates]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = City.new(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = City.new(Map.delete(@valied_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end

    test "does not require capital" do
      {:ok, %City{} = result} = City.new(Map.delete(@valied_attrs, :capital))
      assert is_nil(result.capital)
    end

    test "will accept an empire id for capital" do
      {:ok, %City{} = result} = City.new(Map.put(@valied_attrs, :capital, :storm_giants))
      assert result.capital == :storm_giants
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = City.new!(@valied_attrs)
      assert %City{} = result
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
      assert result.defense == @valied_attrs[:defense]
      assert result.army_templates == @valied_attrs[:army_templates]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        City.new!(%{})
      end
    end
  end
end
