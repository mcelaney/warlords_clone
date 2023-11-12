defmodule Warlords.UnitFixtures do
  alias Warlords.Core.Units.Hero
  alias Warlords.Core.Units.Special
  alias Warlords.Core.Units.Standard

  def hero_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      label: "Brave Sir Robin",
      strength: Enum.random(1..9),
      movement: Enum.random(1..36),
      upkeep: Enum.random(1..15),
      army_type: :hero,
      terrain_access: :rider,
      items: []
    })
  end

  def hero_fixture(attrs \\ %{}) do
    struct(Hero, hero_attrs(attrs))
  end

  def special_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      label: "Dragons",
      strength: Enum.random(1..9),
      movement: Enum.random(1..36),
      upkeep: Enum.random(1..15),
      army_type: :dragon,
      terrain_access: :air,
      blessings: []
    })
  end

  def special_fixture(attrs \\ %{}) do
    struct(Special, hero_attrs(attrs))
  end

  def standard_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      label: "Dragons",
      strength: Enum.random(1..9),
      movement: Enum.random(1..36),
      upkeep: Enum.random(1..15),
      army_type: :dragon,
      terrain_access: :air,
      blessings: []
    })
  end

  def standard_fixture(attrs \\ %{}) do
    struct(Standard, hero_attrs(attrs))
  end
end
