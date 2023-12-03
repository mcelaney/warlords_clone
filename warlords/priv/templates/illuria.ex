defmodule Template.Illuria do
  def empires do
    [
      elvallie: %{id: :elvallie, bank: 59, label: "Elvallie", capital: :marthos},
      grey_dwarves: %{id: :grey_dwarves, bank: 141, label: "Grey Dwarves", capital: :khamar},
      horse_lords: %{id: :horse_lords, bank: 75, label: "Horse Lords", capital: :dunethel},
      lord_bane: %{id: :lord_bane, bank: 102, label: "Lord Bane", capital: :bane_citiadel},
      orcs_of_kor: %{id: :orcs_of_kor, bank: 59, label: "Orcs of Kor", capital: :kor},
      selentines: %{id: :selentines, bank: 86, label: "Selentines", capital: :enmouth},
      sirians: %{id: :sirians, bank: 451, label: "Sirians", capital: :marthos},
      storm_giants: %{id: :storm_giants, bank: 51, label: "Storm Giants", capital: :stormheim},
    ]
  end

  @maximum_unit_strength 9
  def max_strength(), do: @maximum_unit_strength

  def unit_template(), do: Template.Illuria.Units
end
