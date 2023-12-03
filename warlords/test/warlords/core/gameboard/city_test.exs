defmodule Warlords.Gameboard.CityTest do
  use ExUnit.Case, async: true
  import Warlords.GameboardFixtures
  alias Warlords.Core.Gameboard.City

  doctest City

  describe "defense_modifier/1" do
    test "weak cities have no effect" do
      0..1
      |> Enum.each(fn level ->
        city = city_fixture(%{level: level})
        assert City.defense_modifier(city) == 0
      end)
    end

    test "normal cities have effect" do
      2..6
      |> Enum.each(fn level ->
        city = city_fixture(%{level: level})
        assert City.defense_modifier(city) == 1
      end)
    end

    test "strong cities have effect" do
      7..8
      |> Enum.each(fn level ->
        city = city_fixture(%{level: level})
        assert City.defense_modifier(city) == 2
      end)
    end

    test "max cities have effect" do
      city = city_fixture(%{level: 9})
      assert City.defense_modifier(city) == 3
    end
  end
end
