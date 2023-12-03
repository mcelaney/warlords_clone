defmodule Template.Illuria.Cities do
  def starting(empire) do
    case empire do
      :lord_bane -> {:bane_citiadel, {:wolf_riders, 8, 14, 5, 3}}
      :horse_lords -> {:dunethel, {:cavalry, 6, 16, 5, 3}}
      :elvallie -> {:elvallie, {:elven_archers, 4, 12, 4, 1}}
      :selentines -> {:enmouth, {:cavalry, 8, 16, 5, 4}}
      :grey_dwarves -> {:khamar, {:dwarven_legion, 4, 9, 5, 2}}
      :orcs_of_kor -> {:kor, {:giant_wariors, 6, 10, 6, 5}}
      :sirians -> {:marthos, {:cavalry, 8, 16, 6, 4} }
      :storm_giants -> {:stormheim, {:giant_wariors, 4, 12, 6, 2}}
    end
  end

  def list_all do
    [
      ak_enlie: %{label: "Ak-Enlie", level: 4, income: 20, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:elven_archers, 4, 12, 4, 2}]},
      ak_farzon: %{label: "Ak-Farzon", level: 4, income: 20, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:elven_archers, 4, 12, 4, 3}]},
      ak_giriel: %{label: "Ak-Giriel", level: 4, income: 20, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:elven_archers, 4, 12, 4, 3}, {:pegasi, 16, 16, 4, 7}]},
      alfars_gap: %{label: "Alfar's Gap", level: 4, income: 18, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 5, 5}]},
      amenal: %{label: "Amenal", level: 4, income: 16, army_templates: [{:light_infantry, 4, 10, 3, 1}]},
      angbar: %{label: "Angbar", level: 4, income: 20, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 5, 4}]},
      ar_arak: %{label: "Ar-Arak", level: 5, income: 26, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 6, 4}]},
      argenthorn: %{label: "Argenthorn", level: 4, income: 22, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:elven_archers, 4, 12, 4, 1}, {:pegasi, 16, 16, 4, 7}]},
      argrond: %{label: "Argrond", level: 4, income: 17, army_templates: [{:heavy_infantry, 4, 7, 6, 2}, {:light_infantry, 4, 10, 3, 1}]},
      balad_naran: %{label: "Balad Naran", level: 6, income: 29, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:wolf_riders, 8, 15, 6, 2}, {:navy, 20, 18, 5, 11}]},
      bane_citiadel: %{label: "Bane Citiadel", level: 6, income: 30, army_templates: [{:giant_wariors, 4, 10, 6, 4}, {:light_infantry, 4, 12, 3, 1}, {:cavalry, 8, 16, 6, 4}, {:wolf_riders, 8, 14, 5, 3}]},
      barthel: %{label: "Barthel", level: 5, income: 21, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}]},
      beleri: %{label: "Beleri", level: 6, income: 35, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 6, 6}, {:navy, 20, 18, 5, 11}]},
      carmel: %{label: "Carmel", level: 5, income: 20, army_templates: [{:light_infantry, 4, 12, 5, 2}]},
      charling: %{label: "Charling", level: 3, income: 16, army_templates: [{:light_infantry, 4, 10, 3, 1}]},
      citadel_of_fire: %{label: "Citadel of Fire", level: 5, income: 24, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      citadel_of_ice: %{label: "Citadel of Ice", level: 5, income: 26, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      cragmorton: %{label: "Cragmorton", level: 4, income: 23, army_templates: [{:dwarven_legion, 4, 9, 5, 2}, {:griffins, 16, 16, 5, 7}]},
      darclan: %{label: "Darclan", level: 4, income: 19, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:wolf_riders, 8, 14, 5, 3}]},
      deephallow: %{label: "Deephallow", level: 4, income: 23, army_templates: [{:light_infantry, 4, 10, 3, 1}]},
      derridon: %{label: "Derridon", level: 4, income: 20, army_templates: [{:light_infantry, 4, 9, 3, 2}, {:cavalry, 8, 18, 6, 4}]},
      desertion: %{label: "Desertion", level: 4, income: 20, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      dethal: %{label: "Dethal", level: 4, income: 20, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:wolf_riders, 8, 14, 5, 5}]},
      dhar_khosis: %{label: "Dhar-Khosis", level: 6, income: 30, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:dwarven_legion, 4, 9, 5, 2}, {:griffins, 16, 16, 5, 6}]},
      duinoth: %{label: "Duinoth", level: 4, income: 19, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 6, 5}]},
      dunethel: %{label: "Dunethel", level: 6, income: 27, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 6, 19, 6, 3}]},
      elvallie: %{label: "Elvallie", level: 6, income: 33, army_templates: [{:heavy_infantry, 4, 10, 5, 2}, {:elven_archers, 4, 12, 4, 1}, {:pegasi, 16, 16, 4, 6}]},
      enmouth: %{label: "Enmouth", level: 6, income: 35, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 20, 6, 4}, {:navy, 20, 18, 6, 8}]},
      fleymark: %{label: "Fleymark", level: 4, income: 20, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 6, 18, 6, 3}]},
      galin: %{label: "Galin", level: 4, income: 20, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 10, 16, 6, 8}, {:navy, 20, 18, 5, 11}]},
      garom: %{label: "Garom", level: 4, income: 20, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:wolf_riders, 8, 14, 5, 3}]},
      gildenhome: %{label: "Gildenhome", level: 5, income: 24, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:elven_archers, 4, 12, 4, 1}, {:pegasi, 16, 16, 4, 7}]},
      gimlad: %{label: "Gimlad", level: 4, income: 20, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:wolf_riders, 8, 14, 5, 3}]},
      gluk: %{label: "Gluk", level: 4, income: 17, army_templates: [{:giant_wariors, 4, 10, 6, 3}, {:light_infantry, 4, 10, 3, 1}, {:wolf_riders, 8, 14, 5, 3}]},
      gorag: %{label: "Gorag", level: 4, income: 15, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}]},
      gork: %{label: "Gork", level: 4, income: 15, army_templates: [{:giant_wariors, 4, 12, 6, 3}, {:light_infantry, 4, 10, 3, 1}, {:wolf_riders, 8, 14, 5, 3}]},
      greenweigh: %{label: "Greenweigh", level: 4, income: 20, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:dwarven_legion, 4, 9, 5, 3}]},
      gunthang: %{label: "Gunthang", level: 5, income: 25, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:elven_archers, 4, 12, 4, 3}, {:pegasi, 16, 16, 4, 5}]},
      herueth: %{label: "Herueth", level: 6, income: 26, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 6, 6}]},
      herzag: %{label: "Herzag", level: 5, income: 23, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:wolf_riders, 8, 14, 5, 3}, {:navy, 20, 16, 5, 13}]},
      himelton: %{label: "Himelton", level: 3, income: 14, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 5, 6}]},
      hithos: %{label: "Hithos", level: 6, income: 28, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 6, 5}, {:navy, 20, 20, 5, 10}]},
      ilnyr: %{label: "Ilnyr", level: 4, income: 21, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      jessarton: %{label: "Jessarton", level: 4, income: 19, army_templates: [{:light_infantry, 4, 10, 2, 3}, {:navy, 20, 18, 3, 12}]},
      kazrack: %{label: "Kazrack", level: 4, income: 21, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      khamar: %{label: "Khamar", level: 6, income: 37, army_templates: [{:dwarven_legion, 4, 9, 5, 2}, {:griffins, 16, 18, 6, 5}]},
      khorfe: %{label: "Khorfe", level: 5, income: 26, army_templates: [{:dwarven_legion, 4, 9, 5, 2}, {:griffins, 16, 16, 5, 8}]},
      kor: %{label: "Kor", level: 6, income: 30, army_templates: [{:giant_wariors, 6, 10, 6, 5}, {:heavy_infantry, 4, 8, 5, 2}, {:wolf_riders, 8, 14, 5, 3}]},
      lador: %{label: "Lador", level: 4, income: 16, army_templates: [{:light_infantry, 4, 10, 3, 1}]},
      loremark: %{label: "Loremark", level: 4, income: 21, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:elven_archers, 4, 12, 4, 1}, {:pegasi, 16, 16, 4, 7}]},
      malikor: %{label: "Malikor", level: 4, income: 16, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 13, 6, 6}]},
      maridun: %{label: "Maridun", level: 4, income: 18, army_templates: [{:light_infantry, 4, 10, 3, 2}, {:cavalry, 8, 18, 6, 3}]},
      marthos: %{label: "Marthos", level: 6, income: 32, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 6, 4}, {:pegasi, 16, 15, 5, 7}]},
      marton: %{label: "Marton", level: 4, income: 20, army_templates: [{:heavy_infantry, 4, 8, 4, 2}, {:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      meneloth: %{label: "Meneloth", level: 5, income: 25, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 15, 5, 5}]},
      minbourne: %{label: "Minbourne", level: 4, income: 25, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 4, 11}]},
      needleton: %{label: "Needleton", level: 4, income: 24, army_templates: [{:light_infantry, 4, 10, 3, 1}]},
      ohmsmouth: %{label: "Ohmsmouth", level: 5, income: 24, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:navy, 18, 18, 5, 10}]},
      pa_kur: %{label: "Pa-Kur", level: 5, income: 25, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 6, 4}]},
      pareth: %{label: "Pareth", level: 5, income: 22, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 14, 5, 5}]},
      paynor: %{label: "Paynor", level: 3, income: 18, army_templates: [{:light_infantry, 4, 10, 3, 2}]},
      quiesce: %{label: "Quiesce", level: 4, income: 21, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      ssuri: %{label: "Ssuri", level: 4, income: 19, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 5, 4}]},
      stormheim: %{label: "Stormheim", level: 6, income: 20, army_templates: [{:giant_wariors, 4, 12, 6, 2}]},
      tal: %{label: "Tal", level: 4, income: 16, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      tasme: %{label: "Tasme", level: 4, income: 19, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      thurtz: %{label: "Thurtz", level: 4, income: 18, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:wolf_riders, 8, 14, 5, 3}]},
      tirfing: %{label: "Tirfing", level: 4, income: 23, army_templates: [{:light_infantry, 4, 9, 4, 2}]},
      troy: %{label: "Troy", level: 3, income: 13, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 15, 6, 4}]},
      ubar: %{label: "Ubar", level: 4, income: 20, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      ungor: %{label: "Ungor", level: 4, income: 20, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:light_infantry, 4, 10, 3, 1}]},
      upbourne: %{label: "Upbourne", level: 4, income: 17, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:navy, 20, 18, 5, 11}]},
      upway: %{label: "Upway", level: 3, income: 13, army_templates: [{:light_infantry, 4, 10, 3, 2}]},
      varde: %{label: "Varde", level: 4, income: 23, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:cavalry, 8, 16, 5, 5}, {:navy, 20, 18, 5, 11}]},
      vernon: %{label: "Vernon", level: 5, income: 24, army_templates: [{:heavy_infantry, 4, 7, 5, 3}, {:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 6, 11}]},
      vival: %{label: "Vival", level: 3, income: 12, army_templates: [{:light_infantry, 4, 10, 3, 1}]},
      waybourne: %{label: "Waybourne", level: 4, income: 22, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:navy, 20, 18, 5, 11}]},
      wellmore: %{label: "Wellmore", level: 4, income: 20, army_templates: [{:heavy_infantry, 4, 8, 5, 2}, {:navy, 20, 18, 5, 11}]},
      zaigonne: %{label: "Zaigonne", level: 4, income: 20, army_templates: [{:light_infantry, 4, 10, 3, 1}, {:navy, 20, 18, 5, 11}]},
      zhoran: %{label: "Zhoran", level: 5, income: 25, army_templates: [{:dwarven_legion, 4, 9, 5, 1}, {:griffins, 16, 16, 5, 5}]},
    ]
  end
end
