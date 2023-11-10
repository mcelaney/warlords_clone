defmodule Warlords.CombatFixtures do
  @armies ~w(archer cavalry dwarf giant gryffin pegasis spearman swordman wolf)a
  @empires ~w(elvallie grey_dwarves horse_lords lord_bane orcs_of_kor selentines sirians storm_giants)a
  @cities ~w(ashwood blackwater loremark mordor old_valley old_westminster old_york)a

  def valid_army_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      empire: Enum.random(@empires),
      type: Enum.random(@armies),
      origin: Enum.random(@cities),
      stack_number: Enum.random(1..300),
      strength: Enum.random(1..9),
      movement: Enum.random(1..36),
      upkeep: Enum.random(0..36)
    })
  end
end
