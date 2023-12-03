defmodule Warlords.GameboardFixtures do
  alias Warlords.Core.Gameboard.Artifact
  alias Warlords.Core.Gameboard.City
  alias Warlords.Core.Gameboard.Empire
  alias Warlords.Core.Gameboard.Quest
  alias Warlords.Core.Gameboard.Tile

  def artifact_fixture(attrs \\ %{}) do
    %Artifact{
      artifact_key: attrs[:artifact_key] || :loriel_sceptre,
      label: attrs[:label] || "The Sceptre of Loriel",
      strength: attrs[:strength] || 1,
      leadership: attrs[:leadership] || 1
    }
  end

  def city_fixture(attrs \\ %{}) do
    %City{
      city_key: attrs[:city_key] || :ak_enlie,
      label: attrs[:label] || "Ak-Enlie",
      level: attrs[:level] || 4,
      income: attrs[:income] || 20,
      production_count: attrs[:production_count] || 5,
      army_templates:
        attrs[:army_templates] || [{:heavy_infantry, 4, 8, 5, 2}, {:elven_archers, 4, 12, 4, 2}]
    }
  end

  def empire_fixture(attrs \\ %{}) do
    %Empire{
      empire_key: attrs[:empire_key] || :elvallie,
      label: attrs[:label] || "Elvallie",
      bank: attrs[:bank] || 100
    }
  end

  def quest_fixture(attrs \\ %{}) do
    %Quest{
      prize_fn: attrs[:prize_fn] || fn _ -> {:gold, 100} end
    }
  end

  def tile_fixture(attrs \\ %{}) do
    %Tile{
      location: attrs[:location] || {0, 0},
      terrain: attrs[:terrain] || :plain,
      icon: attrs[:icon] || :plain,
      stack: attrs[:stack] || nil,
      tower: attrs[:tower] || false,
      quest: attrs[:quest] || nil,
      city: attrs[:city] || nil
    }
  end

  def attack_formation_tile_fixture(location, terrain, units) do
    stack = Warlords.UnitFixtures.stack_fixture(%{units: units})
    tile_fixture(%{stack: stack, terrain: terrain, location: location})
  end

  def defense_formation_tile_fixture(location, terrain, units) do
    stack = Warlords.UnitFixtures.stack_fixture(%{units: units})
    tile_fixture(%{stack: stack, terrain: terrain, location: location})
  end
end
