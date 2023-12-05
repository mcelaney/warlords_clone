defmodule Warlords.BattleFixtures do
  alias Warlords.Core.Battle.Formation
  alias Warlords.Core.Units.Standard

  def formation_fixture(attrs \\ %{}) do
    %Formation{
      rank: attrs[:rank] || 3,
      strength: attrs[:strength] || 3,
      origin: attrs[:location] || {3, 3},
      unit: attrs[:unit] || unit()
    }
  end

  defp unit() do
    %Standard{
      empire_key: :elvallie,
      label: "Light Infantry",
      rank: 3,
      movement: 10,
      strength: 3,
      production_key: :light_infantry,
      access: :land,
      strength_modifiers: %{hill: -1, forest: 1, marsh: -1}
    }
  end
end
