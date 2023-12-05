defmodule Warlords.Core.Battle do
  @moduledoc """
  The Battle Context
  """

  alias Warlords.Core.Battle.Formation
  alias Warlords.Core.Gameboard.Tile

  @doc """
  Organizes and performs a battle between an attacking tile and defending tiles

  Returns a tuple tagged either attakers or defenders to indicate the winner of
  the battle as well as a list of any surviving units.

  The battle will always result in a winner. Ties are rerolled until broken.
  """
  @spec perform(Tile.t(), [Tile.t()], Tile.t(), (-> integer()), module) ::
          {winner :: :attackers | :defenders, [Formation.t()]}
  def perform(attacker_tile, defender_tiles, target_tile, d12_fn \\ &d12/0, template) do
    resolve_battle(
      Formation.attack_formation(attacker_tile, target_tile, template),
      Formation.defense_formation(defender_tiles, target_tile, template),
      d12_fn
    )
  end

  defp resolve_battle([], defenders, _), do: {:defenders, defenders}
  defp resolve_battle(attackers, [], _), do: {:attackers, attackers}

  defp resolve_battle([attacker | attackers] = offense, [defender | defenders] = defense, d12_fn) do
    attack_val = attacker.strength + d12_fn.()
    defense_val = defender.strength + d12_fn.()

    cond do
      attack_val > defense_val ->
        resolve_battle(offense, defenders, d12_fn)

      attack_val < defense_val ->
        resolve_battle(attackers, defense, d12_fn)

      true ->
        resolve_battle(offense, defense, d12_fn)
    end
  end

  defp d12, do: :rand.uniform(12)
end
