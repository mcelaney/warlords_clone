defmodule Template.Illuria.Quests do
  alias Template.Illuria.Units
  alias Warlords.Core.Gameboard.Artifact

  def cash_prizes do
    [
      fn(_) -> {:gold, 1216} end,
      fn(_) -> {:gold, 1838} end,
      fn(_) -> {:gold, 2595} end,
      fn(_) -> {:gold, 864} end,
    ]
  end

  def quest_rewards do
    [
      fn(_) -> {:strength_modifier, prize_alter()} end,
      fn(_) -> {:strength_modifier, prize_alter()} end,
      fn(_) -> {:strength_modifier, prize_alter()} end,
      fn(_) -> {:strength_modifier, prize_alter()} end,
      fn(_) -> {:strength_modifier, prize_alter()} end,
      fn(_) -> {:artifact, artifacts()[:darksword]} end,
      fn(_) -> {:artifact, artifacts()[:bow_of_eldros]} end,
      fn(_) -> {:artifact, artifacts()[:lightsword]} end,
      fn(_) -> {:artifact, artifacts()[:loriel_crown]} end,
      fn(_) -> {:artifact, artifacts()[:firesword]} end,
      fn(_) -> {:artifact, artifacts()[:horn_of_ages]} end,
      fn(_) -> {:artifact, artifacts()[:loriel_sceptre]} end,
      fn(_) -> {:artifact, artifacts()[:spear_of_ank]} end,
      fn(_) -> {:artifact, artifacts()[:staff_of_might]} end,
      fn(_) -> {:artifact, artifacts()[:ring_of_power]} end,
      fn(_) -> {:artifact, artifacts()[:staff_of_ruling]} end,
      fn(_) -> {:artifact, artifacts()[:crimson_banner]} end,
      fn(_) -> {:artifact, artifacts()[:icesword]} end,
      fn(_) -> {:artifact, artifacts()[:loriel_orb]} end,
      fn(_) -> {:gold, 1062} end,
      fn(_) -> {:gold, 830} end,
      fn(_) -> {:gold, 2082} end,
      fn(_) -> {:gold, 1400} end,
      fn(_) -> {:gold, 1609} end,
      fn(_) -> {:gold, 2336} end,
      fn(_) -> {:gold, 943} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :undead)} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :undead)} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :undead)} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :undead)} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :devils)} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :devils)} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :devils)} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :demons)} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :demons)} end,
      fn(empire) -> {:units, 1..3 |> Enum.random() |>  prize_production(empire, :demons)} end,
      fn(empire) -> {:units, 1..2 |> Enum.random() |>  prize_production(empire, :dragons)} end,
      fn(empire) -> {:units, 1..2 |> Enum.random() |>  prize_production(empire, :dragons)} end,
    ]
  end

  defp prize_alter(), do: Enum.random([-1, 0, 0, 1, 1, 1])

  defp prize_production(num, empire, unit) do
    Enum.map(1..num, fn(_) -> Units.production(empire, unit) end)
  end

  defp artifacts do
    [
      bow_of_eldros: %Artifact{artifact_key: :bow_of_eldros, label: "The Bow of Eldros", strength: 2},
      crimson_banner: %Artifact{artifact_key: :crimson_banner, label: "The Crimson Banner", leadership: 2},
      darksword: %Artifact{artifact_key: :darksword, label: "The Darksword", strength: 2},
      firesword: %Artifact{artifact_key: :firesword, label: "The Firesword", strength: 1},
      horn_of_ages: %Artifact{artifact_key: :horn_of_ages, label: "The Horn of Ages", leadership: 2},
      icesword: %Artifact{artifact_key: :icesword, label: "The Icesword", strength: 1},
      lightsword: %Artifact{artifact_key: :lightsword, label: "The Lightsword", strength: 2},
      loriel_crown: %Artifact{artifact_key: :loriel_crown, label: "The Crown of Loriel", leadership: 1},
      loriel_orb: %Artifact{artifact_key: :loriel_orb, label: "The Orb of Loriel", leadership: 1},
      loriel_sceptre: %Artifact{artifact_key: :loriel_sceptre, label: "The Sceptre of Loriel", leadership: 1},
      ring_of_power: %Artifact{artifact_key: :ring_of_power, label: "The Ring of Power", leadership: 2},
      spear_of_ank: %Artifact{artifact_key: :spear_of_ank, label: "The Spear of Ank", strength: 1},
      staff_of_might: %Artifact{artifact_key: :staff_of_might, label: "The Staff of Might", strength: 3},
      staff_of_ruling: %Artifact{artifact_key: :staff_of_ruling, label: "The Staff of Ruling", leadership: 3},
    ]
  end
end
