defmodule Warlords.Core.Gameboard.CityTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.ProductionTemplate
  alias Warlords.Core.Gameboard.City

  doctest City

  @valid_attrs %{
    id: :ak_enlie,
    label: "Ak-enlie",
    defense: 4,
    army_templates: [
      ProductionTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8})
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

  describe "upgradeable?/1" do
    test "when defense less than the max" do
      city = Gameboard.new_city!(Map.put(@valid_attrs, :defense, 8))
      assert Gameboard.upgradeable?(city)
    end

    test "returns false if the defense is the max" do
      city = Gameboard.new_city!(Map.put(@valid_attrs, :defense, 9))
      refute Gameboard.upgradeable?(city)
    end
  end

  describe "upgrade/1" do
    test "when defense less than the max" do
      city = Gameboard.new_city!(Map.put(@valid_attrs, :defense, 8))
      {:ok, result} = Gameboard.upgrade_city(city)
      assert 9 == result.defense
    end

    test "returns false if the defense is the max" do
      city = Gameboard.new_city!(Map.put(@valid_attrs, :defense, 9))
      {:error, result} = Gameboard.upgrade_city(city)
      assert "City is already at max defense" == result
    end
  end

  describe "defense_modifier/1" do
    test "no defense" do
      for val <- 0..1 do
        city = Gameboard.new_city!(Map.put(@valid_attrs, :defense, val))
        assert 0 == Gameboard.defense_modifier(city)
      end
    end

    test "small defense" do
      for val <- 2..6 do
        city = Gameboard.new_city!(Map.put(@valid_attrs, :defense, val))
        assert 1 == Gameboard.defense_modifier(city)
      end
    end

    test "medium defense" do
      for val <- 7..8 do
        city = Gameboard.new_city!(Map.put(@valid_attrs, :defense, val))
        assert 2 == Gameboard.defense_modifier(city)
      end
    end

    test "max defense" do
      city = Gameboard.new_city!(Map.put(@valid_attrs, :defense, 9))
      assert 3 == Gameboard.defense_modifier(city)
    end
  end
end
