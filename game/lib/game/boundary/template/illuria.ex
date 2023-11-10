defmodule Game.Boundary.Template.Illuria do
  @moduledoc """
  Seed values to produce the original Illuria map.
  """

  alias Game.Core.ArmyTemplate
  alias Game.Core.ArmyType
  alias Game.Core.City
  alias Game.Core.Empire
  alias Game.Core.Item
  alias Game.Core.Terrain

  @spec army_types() :: [key: ArmyType.t()]
  def army_types do
    [
      archer:
        ArmyType.new!(%{id: :archer, label: "Elven Archers", type: :standard, access: :ground}),
      cavalry: ArmyType.new!(%{id: :cavalry, label: "Cavalry", type: :standard, access: :ground}),
      dwarf: ArmyType.new!(%{id: :dwarf, label: "Dwarves", type: :standard, access: :ground}),
      giant: ArmyType.new!(%{id: :giant, label: "Giants", type: :standard, access: :ground}),
      griffin: ArmyType.new!(%{id: :griffin, label: "Griffins", type: :standard, access: :air}),
      navy: ArmyType.new!(%{id: :navy, label: "Navies", type: :standard, access: :sea}),
      pegasis: ArmyType.new!(%{id: :pegasis, label: "Pegasi", type: :standard, access: :air}),
      light_infantry:
        ArmyType.new!(%{
          id: :light_infantry,
          label: "Light Infantry",
          type: :standard,
          access: :ground
        }),
      heavy_infantry:
        ArmyType.new!(%{
          id: :heavy_infantry,
          label: "Heavy Infantry",
          type: :standard,
          access: :ground
        }),
      wolf: ArmyType.new!(%{id: :wolf, label: "Wolf-riders", type: :standard, access: :ground}),
      demon: ArmyType.new!(%{id: :demon, label: "Demons", type: :special, access: :ground}),
      devil: ArmyType.new!(%{id: :devil, label: "Devils", type: :special, access: :ground}),
      dragon: ArmyType.new!(%{id: :dragon, label: "Dragons", type: :special, access: :air}),
      ghost: ArmyType.new!(%{id: :ghost, label: "Undead", type: :special, access: :ground}),
      wizard: ArmyType.new!(%{id: :wizard, label: "Wizards", type: :special, access: :ground}),
      hero: ArmyType.new!(%{id: :hero, label: "Heroes", type: :hero, access: :mimic})
    ]
  end

  @spec cities() :: [key: City.t()]
  def cities do
    [
      ak_enlie:
        City.new!(%{
          id: :ak_enlie,
          label: "Ak-enlie",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :archers, time: 3, cost: 4, strength: 4, movement: 12})
          ]
        }),
      ak_farzon:
        City.new!(%{
          id: :ak_farzon,
          label: "Ak-farzon",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :archers, time: 3, cost: 4, strength: 4, movement: 12})
          ]
        }),
      ak_giriel:
        City.new!(%{
          id: :ak_giriel,
          label: "Ak-giriel",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :archers, time: 3, cost: 4, strength: 4, movement: 12}),
            ArmyTemplate.new!(%{type: :pegasis, time: 7, cost: 16, strength: 4, movement: 16})
          ]
        }),
      alfars_gap:
        City.new!(%{
          id: :alfars_gap,
          label: "Alfar's gap",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 5, cost: 8, strength: 5, movement: 16})
          ]
        }),
      amenal:
        City.new!(%{
          id: :amenal,
          label: "Amenal",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      angbar:
        City.new!(%{
          id: :angbar,
          label: "Angbar",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 4, cost: 8, strength: 5, movement: 16})
          ]
        }),
      ar_arak:
        City.new!(%{
          id: :ar_arak,
          label: "Ar Arak",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 4, cost: 8, strength: 6, movement: 16})
          ]
        }),
      argenthorn:
        City.new!(%{
          id: :argenthorn,
          label: "Argenthorn",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :archers, time: 1, cost: 4, strength: 4, movement: 12}),
            ArmyTemplate.new!(%{type: :pegasis, time: 7, cost: 16, strength: 4, movement: 16})
          ]
        }),
      argrond:
        City.new!(%{
          id: :argrond,
          label: "Argrond",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 6, movement: 7}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      balad_naran:
        City.new!(%{
          id: :balad_naran,
          label: "Balad Naran",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18}),
            ArmyTemplate.new!(%{type: :wolf, time: 2, cost: 8, strength: 6, movement: 15})
          ]
        }),
      bane_ctiadel:
        City.new!(%{
          id: :bane_ctiadel,
          label: "Bane Citadel",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :giant, time: 4, cost: 4, strength: 6, movement: 10}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 4, cost: 8, strength: 6, movement: 16}),
            ArmyTemplate.new!(%{type: :wolf, time: 3, cost: 8, strength: 5, movement: 14})
          ],
          capital: :lord_bane
        }),
      barthel:
        City.new!(%{
          id: :barthel,
          label: "Barthel",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      bereri:
        City.new!(%{
          id: :bereri,
          label: "Bereri",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 6, cost: 8, strength: 6, movement: 16}),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      carmel:
        City.new!(%{
          id: :carmel,
          label: "Carmel",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 12
            })
          ]
        }),
      charling:
        City.new!(%{
          id: :charling,
          label: "Charling",
          defense: 3,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      cit_of_fire:
        City.new!(%{
          id: :cit_of_fire,
          label: "Cit of Fire",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      cit_of_ice:
        City.new!(%{
          id: :cit_of_ice,
          label: "Cit of Ice",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      cragmorton:
        City.new!(%{
          id: :cragmorton,
          label: "Cragmorton",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :dwarf, time: 2, cost: 4, strength: 5, movement: 9}),
            ArmyTemplate.new!(%{type: :griffin, time: 7, cost: 16, strength: 5, movement: 16})
          ]
        }),
      darclan:
        City.new!(%{
          id: :darclan,
          label: "Darclan",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :wolf, time: 3, cost: 8, strength: 5, movement: 14})
          ]
        }),
      deephallow:
        City.new!(%{
          id: :deephallow,
          label: "Deephallow",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      derridon:
        City.new!(%{
          id: :derridon,
          label: "Derridon",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :light_infantry, time: 2, cost: 4, strength: 3, movement: 9}),
            ArmyTemplate.new!(%{type: :cavalry, time: 4, cost: 8, strength: 6, movement: 18})
          ]
        }),
      desertion:
        City.new!(%{
          id: :desertion,
          label: "Desertion",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      dethal:
        City.new!(%{
          id: :dethal,
          label: "Dethal",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :wolf, time: 5, cost: 8, strength: 5, movement: 14})
          ]
        }),
      dhar_khosis:
        City.new!(%{
          id: :dhar_khosis,
          label: "Dhar-khosis",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :dwarf, time: 2, cost: 4, strength: 5, movement: 9}),
            ArmyTemplate.new!(%{type: :griffin, time: 6, cost: 16, strength: 5, movement: 16})
          ]
        }),
      duinoth:
        City.new!(%{
          id: :duinoth,
          label: "Duinoth",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 5, cost: 8, strength: 6, movement: 16})
          ]
        }),
      dunethal:
        City.new!(%{
          id: :dunethal,
          label: "Dunethal",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 3, cost: 6, strength: 6, movement: 19})
          ],
          capital: :horse_lords
        }),
      elvallie:
        City.new!(%{
          id: :elvallie,
          label: "Elvallie",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :archers, time: 1, cost: 4, strength: 4, movement: 12}),
            ArmyTemplate.new!(%{type: :pegasis, time: 6, cost: 16, strength: 4, movement: 16})
          ],
          capital: :elvallie
        }),
      enmouth:
        City.new!(%{
          id: :enmouth,
          label: "Enmouth",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 4, cost: 8, strength: 6, movement: 20}),
            ArmyTemplate.new!(%{type: :navy, time: 8, cost: 20, strength: 6, movement: 18})
          ],
          capital: :selentines
        }),
      fleymark:
        City.new!(%{
          id: :fleymark,
          label: "Fleymark",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 3, cost: 6, strength: 6, movement: 18})
          ]
        }),
      galin:
        City.new!(%{
          id: :galin,
          label: "Galin",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 8, cost: 10, strength: 6, movement: 16}),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      garom:
        City.new!(%{
          id: :garom,
          label: "Garom",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :wolf, time: 3, cost: 8, strength: 5, movement: 14})
          ]
        }),
      gildenhome:
        City.new!(%{
          id: :gildenhome,
          label: "Gildenhome",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :archers, time: 1, cost: 4, strength: 4, movement: 12}),
            ArmyTemplate.new!(%{type: :pegasis, time: 7, cost: 16, strength: 4, movement: 16})
          ]
        }),
      gluk:
        City.new!(%{
          id: :gluk,
          label: "Gluk",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :giant, time: 3, cost: 4, strength: 6, movement: 10}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :wolf, time: 3, cost: 8, strength: 5, movement: 14})
          ]
        }),
      gorag:
        City.new!(%{
          id: :gorag,
          label: "Gorag",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      gork:
        City.new!(%{
          id: :gork,
          label: "Gork",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :giant, time: 5, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :wolf, time: 3, cost: 8, strength: 5, movement: 14})
          ]
        }),
      greenweigh:
        City.new!(%{
          id: :greenweigh,
          label: "Greenweigh",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :dwarf, time: 3, cost: 4, strength: 5, movement: 9})
          ]
        }),
      gunthang:
        City.new!(%{
          id: :gunthang,
          label: "Gunthang",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :archers, time: 3, cost: 4, strength: 4, movement: 12}),
            ArmyTemplate.new!(%{type: :pegasis, time: 5, cost: 16, strength: 4, movement: 16})
          ]
        }),
      hereuth:
        City.new!(%{
          id: :hereuth,
          label: "Hereuth",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 13, cost: 20, strength: 5, movement: 18})
          ]
        }),
      himelton:
        City.new!(%{
          id: :himelton,
          label: "Himelton",
          defense: 3,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 6, cost: 8, strength: 5, movement: 16})
          ]
        }),
      hithos:
        City.new!(%{
          id: :hithos,
          label: "Hithos",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 5, cost: 8, strength: 6, movement: 16}),
            ArmyTemplate.new!(%{type: :navy, time: 10, cost: 20, strength: 5, movement: 20})
          ]
        }),
      ilnyr:
        City.new!(%{
          id: :ilnyr,
          label: "Ilnyr",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      jessarton:
        City.new!(%{
          id: :jessarton,
          label: "Jessarton",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 3,
              cost: 4,
              strength: 2,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 12, cost: 20, strength: 3, movement: 18})
          ]
        }),
      kazrack:
        City.new!(%{
          id: :kazrack,
          label: "Kazrack",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      khamar:
        City.new!(%{
          id: :khamar,
          label: "Khamar",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :dwarf, time: 2, cost: 4, strength: 5, movement: 9}),
            ArmyTemplate.new!(%{type: :griffin, time: 5, cost: 16, strength: 6, movement: 18})
          ],
          capital: :dwarves
        }),
      khorfe:
        City.new!(%{
          id: :khorfe,
          label: "Khorfe",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :dwarf, time: 2, cost: 4, strength: 5, movement: 9}),
            ArmyTemplate.new!(%{type: :griffin, time: 8, cost: 16, strength: 5, movement: 16})
          ]
        }),
      kor:
        City.new!(%{
          id: :kor,
          label: "Kor",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :giant, time: 5, cost: 6, strength: 6, movement: 10}),
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :wolf, time: 3, cost: 8, strength: 5, movement: 14})
          ],
          capital: :orcs_of_kor
        }),
      lador:
        City.new!(%{
          id: :lador,
          label: "Lador",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      loremark:
        City.new!(%{
          id: :loremark,
          label: "Loremark",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :archers, time: 1, cost: 4, strength: 4, movement: 12}),
            ArmyTemplate.new!(%{type: :pegasis, time: 7, cost: 16, strength: 4, movement: 16})
          ]
        }),
      malikor:
        City.new!(%{
          id: :malikor,
          label: "Malikor",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 6, cost: 8, strength: 6, movement: 13})
          ]
        }),
      maridun:
        City.new!(%{
          id: :maridun,
          label: "Maridun",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 3, cost: 8, strength: 6, movement: 18})
          ]
        }),
      marthos:
        City.new!(%{
          id: :marthos,
          label: "Marthos",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 4, cost: 8, strength: 6, movement: 16}),
            ArmyTemplate.new!(%{type: :pegasis, time: 7, cost: 16, strength: 5, movement: 15})
          ],
          capital: :sirians
        }),
      marton:
        City.new!(%{
          id: :marton,
          label: "Marton",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 4, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      meneloth:
        City.new!(%{
          id: :meneloth,
          label: "Meneloth",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 5, cost: 8, strength: 5, movement: 15})
          ]
        }),
      minbourne:
        City.new!(%{
          id: :minbourne,
          label: "Minbourne",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 4, movement: 18})
          ]
        }),
      needleton:
        City.new!(%{
          id: :needleton,
          label: "Needleton",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      ohmsmouth:
        City.new!(%{
          id: :ohmsmouth,
          label: "Ohmsmouth",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :navy, time: 10, cost: 18, strength: 5, movement: 18})
          ]
        }),
      pa_kur:
        City.new!(%{
          id: :pa_kur,
          label: "Pa-kur",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 4, cost: 8, strength: 6, movement: 16})
          ]
        }),
      pareth:
        City.new!(%{
          id: :pareth,
          label: "Pareth",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 5, cost: 8, strength: 5, movement: 14})
          ]
        }),
      paynor:
        City.new!(%{
          id: :paynor,
          label: "Paynor",
          defense: 3,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      quiesce:
        City.new!(%{
          id: :quiesce,
          label: "Quiesce",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      ssuri:
        City.new!(%{
          id: :ssuri,
          label: "Ssuri",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 4, cost: 8, strength: 5, movement: 16})
          ]
        }),
      stormheim:
        City.new!(%{
          id: :stormheim,
          label: "Stormheim",
          defense: 6,
          army_templates: [
            ArmyTemplate.new!(%{type: :giant, time: 2, cost: 4, strength: 6, movement: 12})
          ],
          capital: :storm_giants
        }),
      tal:
        City.new!(%{
          id: :tal,
          label: "Tal",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      tasme:
        City.new!(%{
          id: :tasme,
          label: "Tasme",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      thurtz:
        City.new!(%{
          id: :thurtz,
          label: "Thurtz",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :wolf, time: 3, cost: 8, strength: 5, movement: 14})
          ]
        }),
      tirfing:
        City.new!(%{
          id: :tirfing,
          label: "Tirfing",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :light_infantry, time: 2, cost: 4, strength: 4, movement: 9})
          ]
        }),
      troy:
        City.new!(%{
          id: :troy,
          label: "Troy",
          defense: 3,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 4, cost: 8, strength: 6, movement: 15})
          ]
        }),
      ubar:
        City.new!(%{
          id: :ubar,
          label: "Ubar",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      ungor:
        City.new!(%{
          id: :ungor,
          label: "Ungor",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      upbourne:
        City.new!(%{
          id: :upbourne,
          label: "Upbourne",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      upway:
        City.new!(%{
          id: :upway,
          label: "Upway",
          defense: 3,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      varde:
        City.new!(%{
          id: :varde,
          label: "Varde",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :cavalry, time: 5, cost: 8, strength: 5, movement: 16}),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      vernon:
        City.new!(%{
          id: :vernon,
          label: "Vernon",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 3, cost: 4, strength: 5, movement: 7}),
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 6, movement: 18})
          ]
        }),
      vival:
        City.new!(%{
          id: :vival,
          label: "Vival",
          defense: 3,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      waybourne:
        City.new!(%{
          id: :waybourne,
          label: "Waybourne",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      wellmore:
        City.new!(%{
          id: :wellmore,
          label: "Wellmore",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{type: :heavy_infantry, time: 2, cost: 4, strength: 5, movement: 8}),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      zaigonne:
        City.new!(%{
          id: :zaigonne,
          label: "Zaigonne",
          defense: 4,
          army_templates: [
            ArmyTemplate.new!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            ArmyTemplate.new!(%{type: :navy, time: 11, cost: 20, strength: 5, movement: 18})
          ]
        }),
      zhoran:
        City.new!(%{
          id: :zhoran,
          label: "Zhoran",
          defense: 5,
          army_templates: [
            ArmyTemplate.new!(%{type: :dwarf, time: 1, cost: 4, strength: 5, movement: 9}),
            ArmyTemplate.new!(%{type: :griffin, time: 5, cost: 16, strength: 5, movement: 16})
          ]
        })
    ]
  end

  @spec empires() :: [key: Empire.t()]
  def empires do
    [
      elvallie: Empire.new!(%{id: :elvallie, label: "Elvallie"}),
      grey_dwarves: Empire.new!(%{id: :grey_dwarves, label: "Grey Dwarves"}),
      horse_lords: Empire.new!(%{id: :horse_lords, label: "Horse Lords"}),
      lord_bane: Empire.new!(%{id: :lord_bane, label: "Lord Bane"}),
      orcs_of_kor: Empire.new!(%{id: :orcs_of_kor, label: "Orcs of Kor"}),
      selentines: Empire.new!(%{id: :selentines, label: "Selentines"}),
      sirians: Empire.new!(%{id: :sirians, label: "Sirians"}),
      storm_giants: Empire.new!(%{id: :storm_giants, label: "Storm Giants"})
    ]
  end

  @spec items() :: [key: Item.t()]
  def items do
    [
      bow_of_eldros:
        Item.new!(%{id: :bow_of_eldros, label: "The Bow of Eldros", type: :strength, strength: 2}),
      crimson_banner:
        Item.new!(%{
          id: :crimson_banner,
          label: "The Crimson Banner",
          type: :leadership,
          strength: 1
        }),
      darksword:
        Item.new!(%{id: :darksword, label: "The Darksword", type: :strength, strength: 2}),
      firesword:
        Item.new!(%{id: :firesword, label: "The Firesword", type: :strength, strength: 1}),
      horn_of_ages:
        Item.new!(%{id: :horn_of_ages, label: "The Horn of Ages", type: :leadership, strength: 2}),
      icesword: Item.new!(%{id: :icesword, label: "The Icesword", type: :strength, strength: 1}),
      lightsword:
        Item.new!(%{id: :lightsword, label: "The Lightsword", type: :strength, strength: 2}),
      loriel_crown:
        Item.new!(%{
          id: :loriel_crown,
          label: "The Crown of Loriel",
          type: :leadership,
          strength: 1
        }),
      loriel_orb:
        Item.new!(%{id: :loriel_orb, label: "The Orb of Loriel", type: :leadership, strength: 1}),
      loriel_sceptre:
        Item.new!(%{
          id: :loriel_sceptre,
          label: "The Sceptre of Loriel",
          type: :leadership,
          strength: 1
        }),
      ring_of_power:
        Item.new!(%{
          id: :ring_of_power,
          label: "The Ring of Power",
          type: :leadership,
          strength: 2
        }),
      spear_of_ank:
        Item.new!(%{id: :spear_of_ank, label: "The Spear of Ank", type: :strength, strength: 1}),
      staff_of_might:
        Item.new!(%{
          id: :staff_of_might,
          label: "The Staff of Might",
          type: :strength,
          strength: 3
        }),
      staff_of_ruling:
        Item.new!(%{
          id: :staff_of_ruling,
          label: "The Staff of Ruling",
          type: :leadership,
          strength: 3
        })
    ]
  end

  @spec terrains() :: [key: Terrain.t()]
  def terrains do
    [
      bridge: Terrain.new!(%{id: :bridge, type: :bridge}),
      city: Terrain.new!(%{id: :city, type: :ground}),
      forest: Terrain.new!(%{id: :forest, type: :ground}),
      hill: Terrain.new!(%{id: :hill, type: :ground}),
      marsh: Terrain.new!(%{id: :marsh, type: :ground}),
      mountain: Terrain.new!(%{id: :mountain, type: :restricted}),
      plain: Terrain.new!(%{id: :plain, type: :ground}),
      road: Terrain.new!(%{id: :road, type: :ground}),
      shore: Terrain.new!(%{id: :shore, type: :sea}),
      water: Terrain.new!(%{id: :water, type: :sea})
    ]
  end
end
