defmodule Warlords.UnitFixtures do
  alias Warlords.Core.Units.Hero
  alias Warlords.Core.Units.Special
  alias Warlords.Core.Units.Standard
  alias Warlords.Core.Units.Stack

  def hero_fixture(attrs \\ %{}) do
    %Hero{
      empire_key: attrs[:empire_key] || :elvallie,
      label: attrs[:label] || "Sir Bing",
      rank: attrs[:rank] || 14,
      movement: attrs[:movement] || 16,
      strength: attrs[:strength] || 5,
      production_key: attrs[:production_key] || :hero,
      access: attrs[:access] || :rider,
      artifacts: attrs[:artifacts] || []
    }
  end

  def special_fixture(attrs \\ %{}) do
    %Special{
      empire_key: attrs[:empire_key] || :elvallie,
      label: attrs[:label] || "Dragons",
      rank: attrs[:rank] || 9,
      movement: attrs[:movement] || 16,
      strength: attrs[:strength] || 8,
      production_key: attrs[:production_key] || :dragons,
      access: attrs[:access] || :air
    }
  end

  def standard_fixture(attrs \\ %{}) do
    %Standard{
      empire_key: attrs[:empire_key] || :elvallie,
      label: attrs[:label] || "Light Infantry",
      rank: attrs[:rank] || 3,
      movement: attrs[:movement] || 10,
      strength: attrs[:strength] || 3,
      production_key: attrs[:production_key] || :light_infantry,
      strength_modifiers: attrs[:strength_modifiers] || %{hill: -1, forest: 1, marsh: -1},
      move_modifiers: attrs[:move_modifiers] || %{hill: 1},
      access: attrs[:access] || :land
    }
  end

  def stack_fixture(attrs \\ %{}) do
    %Stack{
      empire_key: attrs[:empire_key] || :elvallie,
      units: attrs[:units] || [standard_fixture()]
    }
  end
end
