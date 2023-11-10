defmodule Warlords.Boundary.Template.Maps.Illuria do
  @moduledoc """
  Seed values to produce the original Illuria map.
  """

  alias Warlords.Core.Gameboard

  @spec army_types() :: [key: ArmyType.t()]
  def army_types do
    [
      archer:
        Gameboard.new_army_type!(%{
          id: :archer,
          label: "Elven Archers",
          type: :standard,
          access: :ground
        }),
      cavalry:
        Gameboard.new_army_type!(%{
          id: :cavalry,
          label: "Cavalry",
          type: :standard,
          access: :ground
        }),
      dwarf:
        Gameboard.new_army_type!(%{id: :dwarf, label: "Dwarves", type: :standard, access: :ground}),
      giant:
        Gameboard.new_army_type!(%{id: :giant, label: "Giants", type: :standard, access: :ground}),
      griffin:
        Gameboard.new_army_type!(%{id: :griffin, label: "Griffins", type: :standard, access: :air}),
      navy:
        Gameboard.new_army_type!(%{id: :navy, label: "Navies", type: :standard, access: :sea}),
      pegasis:
        Gameboard.new_army_type!(%{id: :pegasis, label: "Pegasi", type: :standard, access: :air}),
      light_infantry:
        Gameboard.new_army_type!(%{
          id: :light_infantry,
          label: "Light Infantry",
          type: :standard,
          access: :ground
        }),
      heavy_infantry:
        Gameboard.new_army_type!(%{
          id: :heavy_infantry,
          label: "Heavy Infantry",
          type: :standard,
          access: :ground
        }),
      wolf:
        Gameboard.new_army_type!(%{
          id: :wolf,
          label: "Wolf-riders",
          type: :standard,
          access: :ground
        }),
      demon:
        Gameboard.new_army_type!(%{id: :demon, label: "Demons", type: :special, access: :ground}),
      devil:
        Gameboard.new_army_type!(%{id: :devil, label: "Devils", type: :special, access: :ground}),
      dragon:
        Gameboard.new_army_type!(%{id: :dragon, label: "Dragons", type: :special, access: :air}),
      ghost:
        Gameboard.new_army_type!(%{id: :ghost, label: "Undead", type: :special, access: :ground}),
      wizard:
        Gameboard.new_army_type!(%{id: :wizard, label: "Wizards", type: :special, access: :ground}),
      hero: Gameboard.new_army_type!(%{id: :hero, label: "Heroes", type: :hero, access: :mimic})
    ]
  end

  @spec cities() :: [key: City.t()]
  def cities do
    [
      ak_enlie:
        Gameboard.new_city!(%{
          id: :ak_enlie,
          label: "Ak-enlie",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :archers,
              time: 3,
              cost: 4,
              strength: 4,
              movement: 12
            })
          ]
        }),
      ak_farzon:
        Gameboard.new_city!(%{
          id: :ak_farzon,
          label: "Ak-farzon",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :archers,
              time: 3,
              cost: 4,
              strength: 4,
              movement: 12
            })
          ]
        }),
      ak_giriel:
        Gameboard.new_city!(%{
          id: :ak_giriel,
          label: "Ak-giriel",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :archers,
              time: 3,
              cost: 4,
              strength: 4,
              movement: 12
            }),
            Gameboard.new_army_template!(%{
              type: :pegasis,
              time: 7,
              cost: 16,
              strength: 4,
              movement: 16
            })
          ]
        }),
      alfars_gap:
        Gameboard.new_city!(%{
          id: :alfars_gap,
          label: "Alfar's gap",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 5,
              cost: 8,
              strength: 5,
              movement: 16
            })
          ]
        }),
      amenal:
        Gameboard.new_city!(%{
          id: :amenal,
          label: "Amenal",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      angbar:
        Gameboard.new_city!(%{
          id: :angbar,
          label: "Angbar",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 4,
              cost: 8,
              strength: 5,
              movement: 16
            })
          ]
        }),
      ar_arak:
        Gameboard.new_city!(%{
          id: :ar_arak,
          label: "Ar Arak",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 4,
              cost: 8,
              strength: 6,
              movement: 16
            })
          ]
        }),
      argenthorn:
        Gameboard.new_city!(%{
          id: :argenthorn,
          label: "Argenthorn",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :archers,
              time: 1,
              cost: 4,
              strength: 4,
              movement: 12
            }),
            Gameboard.new_army_template!(%{
              type: :pegasis,
              time: 7,
              cost: 16,
              strength: 4,
              movement: 16
            })
          ]
        }),
      argrond:
        Gameboard.new_city!(%{
          id: :argrond,
          label: "Argrond",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 6,
              movement: 7
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      balad_naran:
        Gameboard.new_city!(%{
          id: :balad_naran,
          label: "Balad Naran",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            }),
            Gameboard.new_army_template!(%{
              type: :wolf,
              time: 2,
              cost: 8,
              strength: 6,
              movement: 15
            })
          ]
        }),
      bane_ctiadel:
        Gameboard.new_city!(%{
          id: :bane_ctiadel,
          label: "Bane Citadel",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :giant,
              time: 4,
              cost: 4,
              strength: 6,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 4,
              cost: 8,
              strength: 6,
              movement: 16
            }),
            Gameboard.new_army_template!(%{
              type: :wolf,
              time: 3,
              cost: 8,
              strength: 5,
              movement: 14
            })
          ],
          capital: :lord_bane
        }),
      barthel:
        Gameboard.new_city!(%{
          id: :barthel,
          label: "Barthel",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      bereri:
        Gameboard.new_city!(%{
          id: :bereri,
          label: "Bereri",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 6,
              cost: 8,
              strength: 6,
              movement: 16
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      carmel:
        Gameboard.new_city!(%{
          id: :carmel,
          label: "Carmel",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 12
            })
          ]
        }),
      charling:
        Gameboard.new_city!(%{
          id: :charling,
          label: "Charling",
          defense: 3,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      cit_of_fire:
        Gameboard.new_city!(%{
          id: :cit_of_fire,
          label: "Cit of Fire",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      cit_of_ice:
        Gameboard.new_city!(%{
          id: :cit_of_ice,
          label: "Cit of Ice",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      cragmorton:
        Gameboard.new_city!(%{
          id: :cragmorton,
          label: "Cragmorton",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :dwarf,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 9
            }),
            Gameboard.new_army_template!(%{
              type: :griffin,
              time: 7,
              cost: 16,
              strength: 5,
              movement: 16
            })
          ]
        }),
      darclan:
        Gameboard.new_city!(%{
          id: :darclan,
          label: "Darclan",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :wolf,
              time: 3,
              cost: 8,
              strength: 5,
              movement: 14
            })
          ]
        }),
      deephallow:
        Gameboard.new_city!(%{
          id: :deephallow,
          label: "Deephallow",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      derridon:
        Gameboard.new_city!(%{
          id: :derridon,
          label: "Derridon",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 3,
              movement: 9
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 4,
              cost: 8,
              strength: 6,
              movement: 18
            })
          ]
        }),
      desertion:
        Gameboard.new_city!(%{
          id: :desertion,
          label: "Desertion",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      dethal:
        Gameboard.new_city!(%{
          id: :dethal,
          label: "Dethal",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :wolf,
              time: 5,
              cost: 8,
              strength: 5,
              movement: 14
            })
          ]
        }),
      dhar_khosis:
        Gameboard.new_city!(%{
          id: :dhar_khosis,
          label: "Dhar-khosis",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :dwarf,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 9
            }),
            Gameboard.new_army_template!(%{
              type: :griffin,
              time: 6,
              cost: 16,
              strength: 5,
              movement: 16
            })
          ]
        }),
      duinoth:
        Gameboard.new_city!(%{
          id: :duinoth,
          label: "Duinoth",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 5,
              cost: 8,
              strength: 6,
              movement: 16
            })
          ]
        }),
      dunethal:
        Gameboard.new_city!(%{
          id: :dunethal,
          label: "Dunethal",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 3,
              cost: 6,
              strength: 6,
              movement: 19
            })
          ],
          capital: :horse_lords
        }),
      elvallie:
        Gameboard.new_city!(%{
          id: :elvallie,
          label: "Elvallie",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :archers,
              time: 1,
              cost: 4,
              strength: 4,
              movement: 12
            }),
            Gameboard.new_army_template!(%{
              type: :pegasis,
              time: 6,
              cost: 16,
              strength: 4,
              movement: 16
            })
          ],
          capital: :elvallie
        }),
      enmouth:
        Gameboard.new_city!(%{
          id: :enmouth,
          label: "Enmouth",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 4,
              cost: 8,
              strength: 6,
              movement: 20
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 8,
              cost: 20,
              strength: 6,
              movement: 18
            })
          ],
          capital: :selentines
        }),
      fleymark:
        Gameboard.new_city!(%{
          id: :fleymark,
          label: "Fleymark",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 3,
              cost: 6,
              strength: 6,
              movement: 18
            })
          ]
        }),
      galin:
        Gameboard.new_city!(%{
          id: :galin,
          label: "Galin",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 8,
              cost: 10,
              strength: 6,
              movement: 16
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      garom:
        Gameboard.new_city!(%{
          id: :garom,
          label: "Garom",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :wolf,
              time: 3,
              cost: 8,
              strength: 5,
              movement: 14
            })
          ]
        }),
      gildenhome:
        Gameboard.new_city!(%{
          id: :gildenhome,
          label: "Gildenhome",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :archers,
              time: 1,
              cost: 4,
              strength: 4,
              movement: 12
            }),
            Gameboard.new_army_template!(%{
              type: :pegasis,
              time: 7,
              cost: 16,
              strength: 4,
              movement: 16
            })
          ]
        }),
      gluk:
        Gameboard.new_city!(%{
          id: :gluk,
          label: "Gluk",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :giant,
              time: 3,
              cost: 4,
              strength: 6,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :wolf,
              time: 3,
              cost: 8,
              strength: 5,
              movement: 14
            })
          ]
        }),
      gorag:
        Gameboard.new_city!(%{
          id: :gorag,
          label: "Gorag",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      gork:
        Gameboard.new_city!(%{
          id: :gork,
          label: "Gork",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :giant,
              time: 5,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :wolf,
              time: 3,
              cost: 8,
              strength: 5,
              movement: 14
            })
          ]
        }),
      greenweigh:
        Gameboard.new_city!(%{
          id: :greenweigh,
          label: "Greenweigh",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :dwarf,
              time: 3,
              cost: 4,
              strength: 5,
              movement: 9
            })
          ]
        }),
      gunthang:
        Gameboard.new_city!(%{
          id: :gunthang,
          label: "Gunthang",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :archers,
              time: 3,
              cost: 4,
              strength: 4,
              movement: 12
            }),
            Gameboard.new_army_template!(%{
              type: :pegasis,
              time: 5,
              cost: 16,
              strength: 4,
              movement: 16
            })
          ]
        }),
      hereuth:
        Gameboard.new_city!(%{
          id: :hereuth,
          label: "Hereuth",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 13,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      himelton:
        Gameboard.new_city!(%{
          id: :himelton,
          label: "Himelton",
          defense: 3,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 6,
              cost: 8,
              strength: 5,
              movement: 16
            })
          ]
        }),
      hithos:
        Gameboard.new_city!(%{
          id: :hithos,
          label: "Hithos",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 5,
              cost: 8,
              strength: 6,
              movement: 16
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 10,
              cost: 20,
              strength: 5,
              movement: 20
            })
          ]
        }),
      ilnyr:
        Gameboard.new_city!(%{
          id: :ilnyr,
          label: "Ilnyr",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      jessarton:
        Gameboard.new_city!(%{
          id: :jessarton,
          label: "Jessarton",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 3,
              cost: 4,
              strength: 2,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 12,
              cost: 20,
              strength: 3,
              movement: 18
            })
          ]
        }),
      kazrack:
        Gameboard.new_city!(%{
          id: :kazrack,
          label: "Kazrack",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      khamar:
        Gameboard.new_city!(%{
          id: :khamar,
          label: "Khamar",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :dwarf,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 9
            }),
            Gameboard.new_army_template!(%{
              type: :griffin,
              time: 5,
              cost: 16,
              strength: 6,
              movement: 18
            })
          ],
          capital: :dwarves
        }),
      khorfe:
        Gameboard.new_city!(%{
          id: :khorfe,
          label: "Khorfe",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :dwarf,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 9
            }),
            Gameboard.new_army_template!(%{
              type: :griffin,
              time: 8,
              cost: 16,
              strength: 5,
              movement: 16
            })
          ]
        }),
      kor:
        Gameboard.new_city!(%{
          id: :kor,
          label: "Kor",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :giant,
              time: 5,
              cost: 6,
              strength: 6,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :wolf,
              time: 3,
              cost: 8,
              strength: 5,
              movement: 14
            })
          ],
          capital: :orcs_of_kor
        }),
      lador:
        Gameboard.new_city!(%{
          id: :lador,
          label: "Lador",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      loremark:
        Gameboard.new_city!(%{
          id: :loremark,
          label: "Loremark",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :archers,
              time: 1,
              cost: 4,
              strength: 4,
              movement: 12
            }),
            Gameboard.new_army_template!(%{
              type: :pegasis,
              time: 7,
              cost: 16,
              strength: 4,
              movement: 16
            })
          ]
        }),
      malikor:
        Gameboard.new_city!(%{
          id: :malikor,
          label: "Malikor",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 6,
              cost: 8,
              strength: 6,
              movement: 13
            })
          ]
        }),
      maridun:
        Gameboard.new_city!(%{
          id: :maridun,
          label: "Maridun",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 3,
              cost: 8,
              strength: 6,
              movement: 18
            })
          ]
        }),
      marthos:
        Gameboard.new_city!(%{
          id: :marthos,
          label: "Marthos",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 4,
              cost: 8,
              strength: 6,
              movement: 16
            }),
            Gameboard.new_army_template!(%{
              type: :pegasis,
              time: 7,
              cost: 16,
              strength: 5,
              movement: 15
            })
          ],
          capital: :sirians
        }),
      marton:
        Gameboard.new_city!(%{
          id: :marton,
          label: "Marton",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 4,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      meneloth:
        Gameboard.new_city!(%{
          id: :meneloth,
          label: "Meneloth",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 5,
              cost: 8,
              strength: 5,
              movement: 15
            })
          ]
        }),
      minbourne:
        Gameboard.new_city!(%{
          id: :minbourne,
          label: "Minbourne",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 4,
              movement: 18
            })
          ]
        }),
      needleton:
        Gameboard.new_city!(%{
          id: :needleton,
          label: "Needleton",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      ohmsmouth:
        Gameboard.new_city!(%{
          id: :ohmsmouth,
          label: "Ohmsmouth",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 10,
              cost: 18,
              strength: 5,
              movement: 18
            })
          ]
        }),
      pa_kur:
        Gameboard.new_city!(%{
          id: :pa_kur,
          label: "Pa-kur",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 4,
              cost: 8,
              strength: 6,
              movement: 16
            })
          ]
        }),
      pareth:
        Gameboard.new_city!(%{
          id: :pareth,
          label: "Pareth",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 5,
              cost: 8,
              strength: 5,
              movement: 14
            })
          ]
        }),
      paynor:
        Gameboard.new_city!(%{
          id: :paynor,
          label: "Paynor",
          defense: 3,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      quiesce:
        Gameboard.new_city!(%{
          id: :quiesce,
          label: "Quiesce",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      ssuri:
        Gameboard.new_city!(%{
          id: :ssuri,
          label: "Ssuri",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 4,
              cost: 8,
              strength: 5,
              movement: 16
            })
          ]
        }),
      stormheim:
        Gameboard.new_city!(%{
          id: :stormheim,
          label: "Stormheim",
          defense: 6,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :giant,
              time: 2,
              cost: 4,
              strength: 6,
              movement: 12
            })
          ],
          capital: :storm_giants
        }),
      tal:
        Gameboard.new_city!(%{
          id: :tal,
          label: "Tal",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      tasme:
        Gameboard.new_city!(%{
          id: :tasme,
          label: "Tasme",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      thurtz:
        Gameboard.new_city!(%{
          id: :thurtz,
          label: "Thurtz",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :wolf,
              time: 3,
              cost: 8,
              strength: 5,
              movement: 14
            })
          ]
        }),
      tirfing:
        Gameboard.new_city!(%{
          id: :tirfing,
          label: "Tirfing",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 4,
              movement: 9
            })
          ]
        }),
      troy:
        Gameboard.new_city!(%{
          id: :troy,
          label: "Troy",
          defense: 3,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 4,
              cost: 8,
              strength: 6,
              movement: 15
            })
          ]
        }),
      ubar:
        Gameboard.new_city!(%{
          id: :ubar,
          label: "Ubar",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      ungor:
        Gameboard.new_city!(%{
          id: :ungor,
          label: "Ungor",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      upbourne:
        Gameboard.new_city!(%{
          id: :upbourne,
          label: "Upbourne",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      upway:
        Gameboard.new_city!(%{
          id: :upway,
          label: "Upway",
          defense: 3,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 2,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      varde:
        Gameboard.new_city!(%{
          id: :varde,
          label: "Varde",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :cavalry,
              time: 5,
              cost: 8,
              strength: 5,
              movement: 16
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      vernon:
        Gameboard.new_city!(%{
          id: :vernon,
          label: "Vernon",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 3,
              cost: 4,
              strength: 5,
              movement: 7
            }),
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 6,
              movement: 18
            })
          ]
        }),
      vival:
        Gameboard.new_city!(%{
          id: :vival,
          label: "Vival",
          defense: 3,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            })
          ]
        }),
      waybourne:
        Gameboard.new_city!(%{
          id: :waybourne,
          label: "Waybourne",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      wellmore:
        Gameboard.new_city!(%{
          id: :wellmore,
          label: "Wellmore",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :heavy_infantry,
              time: 2,
              cost: 4,
              strength: 5,
              movement: 8
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      zaigonne:
        Gameboard.new_city!(%{
          id: :zaigonne,
          label: "Zaigonne",
          defense: 4,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :light_infantry,
              time: 1,
              cost: 4,
              strength: 3,
              movement: 10
            }),
            Gameboard.new_army_template!(%{
              type: :navy,
              time: 11,
              cost: 20,
              strength: 5,
              movement: 18
            })
          ]
        }),
      zhoran:
        Gameboard.new_city!(%{
          id: :zhoran,
          label: "Zhoran",
          defense: 5,
          army_templates: [
            Gameboard.new_army_template!(%{
              type: :dwarf,
              time: 1,
              cost: 4,
              strength: 5,
              movement: 9
            }),
            Gameboard.new_army_template!(%{
              type: :griffin,
              time: 5,
              cost: 16,
              strength: 5,
              movement: 16
            })
          ]
        })
    ]
  end

  @spec empires() :: [key: Empire.t()]
  def empires do
    [
      elvallie: Gameboard.new_empire!(%{id: :elvallie, label: "Elvallie"}),
      grey_dwarves: Gameboard.new_empire!(%{id: :grey_dwarves, label: "Grey Dwarves"}),
      horse_lords: Gameboard.new_empire!(%{id: :horse_lords, label: "Horse Lords"}),
      lord_bane: Gameboard.new_empire!(%{id: :lord_bane, label: "Lord Bane"}),
      orcs_of_kor: Gameboard.new_empire!(%{id: :orcs_of_kor, label: "Orcs of Kor"}),
      selentines: Gameboard.new_empire!(%{id: :selentines, label: "Selentines"}),
      sirians: Gameboard.new_empire!(%{id: :sirians, label: "Sirians"}),
      storm_giants: Gameboard.new_empire!(%{id: :storm_giants, label: "Storm Giants"})
    ]
  end

  @spec items() :: [key: Item.t()]
  def items do
    [
      bow_of_eldros:
        Gameboard.new_item!(%{
          id: :bow_of_eldros,
          label: "The Bow of Eldros",
          type: :strength,
          strength: 2
        }),
      crimson_banner:
        Gameboard.new_item!(%{
          id: :crimson_banner,
          label: "The Crimson Banner",
          type: :leadership,
          strength: 1
        }),
      darksword:
        Gameboard.new_item!(%{
          id: :darksword,
          label: "The Darksword",
          type: :strength,
          strength: 2
        }),
      firesword:
        Gameboard.new_item!(%{
          id: :firesword,
          label: "The Firesword",
          type: :strength,
          strength: 1
        }),
      horn_of_ages:
        Gameboard.new_item!(%{
          id: :horn_of_ages,
          label: "The Horn of Ages",
          type: :leadership,
          strength: 2
        }),
      icesword:
        Gameboard.new_item!(%{id: :icesword, label: "The Icesword", type: :strength, strength: 1}),
      lightsword:
        Gameboard.new_item!(%{
          id: :lightsword,
          label: "The Lightsword",
          type: :strength,
          strength: 2
        }),
      loriel_crown:
        Gameboard.new_item!(%{
          id: :loriel_crown,
          label: "The Crown of Loriel",
          type: :leadership,
          strength: 1
        }),
      loriel_orb:
        Gameboard.new_item!(%{
          id: :loriel_orb,
          label: "The Orb of Loriel",
          type: :leadership,
          strength: 1
        }),
      loriel_sceptre:
        Gameboard.new_item!(%{
          id: :loriel_sceptre,
          label: "The Sceptre of Loriel",
          type: :leadership,
          strength: 1
        }),
      ring_of_power:
        Gameboard.new_item!(%{
          id: :ring_of_power,
          label: "The Ring of Power",
          type: :leadership,
          strength: 2
        }),
      spear_of_ank:
        Gameboard.new_item!(%{
          id: :spear_of_ank,
          label: "The Spear of Ank",
          type: :strength,
          strength: 1
        }),
      staff_of_might:
        Gameboard.new_item!(%{
          id: :staff_of_might,
          label: "The Staff of Might",
          type: :strength,
          strength: 3
        }),
      staff_of_ruling:
        Gameboard.new_item!(%{
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
      bridge: Gameboard.new_terrain!(%{id: :bridge, type: :bridge}),
      city: Gameboard.new_terrain!(%{id: :city, type: :ground}),
      forest: Gameboard.new_terrain!(%{id: :forest, type: :ground}),
      hill: Gameboard.new_terrain!(%{id: :hill, type: :ground}),
      marsh: Gameboard.new_terrain!(%{id: :marsh, type: :ground}),
      mountain: Gameboard.new_terrain!(%{id: :mountain, type: :restricted}),
      plain: Gameboard.new_terrain!(%{id: :plain, type: :ground}),
      road: Gameboard.new_terrain!(%{id: :road, type: :ground}),
      shore: Gameboard.new_terrain!(%{id: :shore, type: :sea}),
      water: Gameboard.new_terrain!(%{id: :water, type: :sea})
    ]
  end
end
