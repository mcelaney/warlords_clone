defmodule Template.Illuria.Units do
  alias Warlords.Core.Units.Hero
  alias Warlords.Core.Units.Special
  alias Warlords.Core.Units.Standard

  def production(empire, {production_key, cost, movement, strength, _time}) do
    case production_key do
      :navy ->
        %Standard{empire_key: empire, production_key: :navy, rank: 15, label: "Navy", access: :sea, movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:navy, empire), move_modifiers: move_modifiers()}
      :griffins ->
        %Standard{empire_key: empire, production_key: :griffins, rank: 8, label: "Griffins", access: :air, movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:griffins, empire), move_modifiers: move_modifiers()}
      :pegasi ->
        %Standard{empire_key: empire, production_key: :pegasi, rank: 7, label: "Pegasi", access: :air, movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:pegasi, empire), move_modifiers: move_modifiers()}
      :cavalry ->
        %Standard{empire_key: empire, production_key: :cavalry, rank: 5, label: "Cavalry", access: :land, move_modifiers: move_modifiers(%{forest: 1,hill: 1}), movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:cavalry, empire)}
      :wolf_riders ->
        %Standard{empire_key: empire, production_key: :wolf_riders, rank: 6, label: "Wolf Riders", access: :land, move_modifiers: move_modifiers(%{hill: 1, marsh: -1}), movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:wolf_riders, empire)}
      :dwarven_legion ->
        %Standard{empire_key: empire, production_key: :dwarven_legion, rank: 1, label: "Dwarven Legion", access: :land, move_modifiers: move_modifiers(%{forest: 2,hill: -2, marsh: 1}), movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:dwarven_legion, empire)}
      :giant_wariors ->
        %Standard{empire_key: empire, production_key: :giant_wariors, rank: 0, label: "Giant Wariors", access: :land, move_modifiers: move_modifiers(%{forest: 1,hill: -1}), movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:giant_wariors, empire)}
      :heavy_infantry ->
        %Standard{empire_key: empire, production_key: :heavy_infantry, rank: 2, label: "Heavy Infantry", access: :land, move_modifiers: move_modifiers(%{hill: 1}), movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:heavy_infantry, empire)}
      :elven_archers ->
        %Standard{empire_key: empire, production_key: :elven_archers, rank: 4,  label: "Elven Archers", access: :land, move_modifiers: move_modifiers(%{forest: -2, marsh: 1}), movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:elven_archers, empire)}
      :light_infantry->
        %Standard{empire_key: empire, production_key: :light_infantry, rank: 3, label: "Light Infantry", access: :land, move_modifiers: move_modifiers(%{hill: 1}), movement: movement, strength: strength, upkeep: div(cost, 2), strength_modifiers: attack_modifiers(:light_infantry, empire)}
    end
  end

  def production(empire, production_key) do
    case production_key do
      :hero ->
        %Hero{empire_key: empire, production_key: :hero, rank: 14, label: "A new hero", access: :rider, strength: 5, movement: 16, strength_modifiers: attack_modifiers(:hero, empire), move_modifiers: move_modifiers(%{hill: 1})}
      :dragons ->
        %Special{empire_key: empire, production_key: :dragons, rank: 13,  label: "Dragons", access: :air, strength: 8, movement: 18, strength_modifiers: attack_modifiers(:dragons, empire), move_modifiers: move_modifiers()}
      :devils ->
        %Special{empire_key: empire, production_key: :devils, rank: 12, label: "Devils", access: :land, strength: 8, movement: 12, strength_modifiers: attack_modifiers(:devils, empire), move_modifiers: move_modifiers()}
      :demons ->
        %Special{empire_key: empire, production_key: :demons, rank: 11, label: "Demons", access: :land, strength: 7, movement: 14, strength_modifiers: attack_modifiers(:demons, empire), move_modifiers: move_modifiers()}
      :undead ->
        %Special{empire_key: empire, production_key: :undead, rank: 10, label: "Undead", access: :land, strength: 7, movement: 12, strength_modifiers: attack_modifiers(:undead, empire), move_modifiers: move_modifiers(%{marsh: -1})}
      :wizards ->
        %Special{empire_key: empire, production_key: :wizards, rank: 9, label: "Wizards", access: :land, strength: 6, movement: 46, strength_modifiers: attack_modifiers(:wizards, empire), move_modifiers: move_modifiers(%{hill: 1})}
    end
  end

  def knight_names do
    ["Aelfere", "Aelfwine", "Alex the Black", "Baron Roger", "Baroness Lucy",
    "Brandegoris", "Brus avec Pitie", "Brus sans Pitie", "Captain J",
    "Countess Lyn", "Countess Phil", "Don Stephano", "Doon de Mayence",
    "Duke Aymon", "Duke Tintagel", "Eadweard", "Ealhelm", "Earl Steven",
    "Friar Tuck", "Garin de Monglane", "General Beatrix", "Glen Cott",
    "Grenseal", "Guy of Gisbourne", "Guy of Warwick", "Huon of Bordeaux",
    "Ian Chesterton", "Integra Hellsing", "Joan d'Arc", "Joshua Levenheit",
    "Kahedin", "Kain Highwind", "Kian Alvane", "Lady Donna", "Lady Lai",
    "Leofsunu", "Little John", "Lord Falkner", "Lord Graeme", "Lord Melyodas",
    "Morganoure", "Neinhalt Sieger", "Ogier the Dane", "Powerwis",
    "Prince Valiant", "Rowan the Red", "Salome Harras", "Seifer Almasy",
    "Sir Blubrys", "Sir Bradamante", "Sir Ector", "Sir Galahad", "Sir Gareth",
    "Sir Gawain", "Sir Gregor", "Sir Kay", "Sir Lamerok", "Sir Lancelot",
    "Sir Lucane", "Sir Metax", "Sir Mike Red", "Sir Mordred", "Sir Palomides",
    "Sir Patrick Spens", "Sir Pelleus", "Sir Percivale", "Sir Plomyde",
    "Sir Tristram", "Snowe Vingerhut", "Steyn White", "Viscount Nick",
    "Will Scarlet", "Yann Wenz"]
  end

  defp move_modifiers(attrs \\ %{}) do
    Enum.into(attrs, %{bridge: 0, forest: 0, hill: 0, marsh: 0, plain: 0, road: 0, water: 0})
  end

  defp attack_modifiers(production_key, empire) do
    [:bridge, :forest, :hill, :marsh, :plain, :road, :water]
    |> Enum.reduce(%{}, fn key, acc ->
      value = production_key_based_modifiers(production_key, key) + empire_based_modifiers(empire, key)
      Map.put(acc, key, value)
    end)
  end

  defp empire_based_modifiers(empire, key) do
    values =
      case empire do
        :elvallie -> %{hill: -1, forest: 1, marsh: -1}
        :grey_dwarves -> %{hill: 2, forest: -1, marsh: -1}
        :horse_lords -> %{road: 1, bridge: 1, forest: -1, hill: -1, plain: 1}
        :lord_bane -> %{forest: -1, marsh: 1}
        :orcs_of_kor -> %{forest: -1, marsh: 1}
        :selentines -> %{water: 1, bridge: 1, marsh: -1, hill: -1}
        :sirians -> %{road: 1, bridge: 1, plain: 1}
        :storm_giants -> %{hill: 1, marsh: -1}
        _ -> %{}
      end
    values[key] || 0
  end

  defp production_key_based_modifiers(production_key, key) do
    values =
      case production_key do
        :navy -> %{}
        :griffins -> %{hill: 1}
        :pegasi -> %{forest: 1}
        :cavalry -> %{hill: -1, forest: -1, marsh: -1}
        :wolf_riders -> %{hill: -1, forest: -1}
        :dwarven_legion -> %{hill: 1, forest: -1}
        :giant_wariors -> %{forest: -1}
        :heavy_infantry -> %{hill: -1, forest: -1, marsh: -1}
        :elven_archers -> %{hill: -1, forest: 1, marsh: -1}
        :light_infantry -> %{hill: -1, forest: -1, marsh: -1}
        :devils -> %{forest: -1}
        :demons -> %{forest: -1}
        :undead -> %{forest: -1, marsh: 1}
        :hero -> %{hill: 1}
        _ -> %{}
      end
    values[key] || 0
  end
end
