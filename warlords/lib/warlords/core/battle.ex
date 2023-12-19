defmodule Warlords.Core.Battle do
  @moduledoc """
  The Battle Context
  """

  alias Warlords.Core.Battle.Formation

  @doc """
  Organizes and performs a battle between an attacking tile and defending tiles

  Returns a tuple tagged either attakers or defenders to indicate the winner of
  the battle as well as a list of any surviving units.

  The battle will always result in a winner. Ties are rerolled until broken.

  This function is set up this way to allow us to isolate the die roll from d12/1
  for testing as it returns a random number between 1 and 12.

  Function defaults are for testing purposes and should not be used in production
  as any functions passed in will only be leveraged on the first step of a battle.
  All subsequent steps will use the default functions.

  """
  @spec perform([Formation.t()], [Formation.t()]) :: {:attacker | :defender, [Formation.t()]}
  @spec perform([Formation.t()], [Formation.t()], fun, fun, fun) ::
          {:attacker | :defender, [Formation.t()]}
  def perform(
        attackers,
        defenders,
        pref_off_fn \\ &next_unit_attack/1,
        prep_def_fn \\ &next_unit_attack/1,
        next_step_fn \\ &next_step/3
      )

  def perform(attackers, defenders, pref_off_fn, prep_def_fn, next_step_fn) do
    with {attack_strength, offense} <- pref_off_fn.(attackers),
         {defense_strength, defense} <- prep_def_fn.(defenders),
         result <- find_winner(attack_strength, defense_strength) do
      next_step_fn.(result, offense, defense)
    end
  end

  @spec next_unit_attack([Formation.t()], (-> integer())) :: {integer, [Formation.t()]}
  def next_unit_attack([head | _tail] = units, d12_fn \\ &d12/0),
    do: {head.strength + d12_fn.(), units}

  @spec next_step(atom, [Formation.t()], [Formation.t()], fun) ::
          {:attacker | :defender, [Formation.t()]}
  def next_step(
        result,
        [_ | remaining_attackers] = attackers,
        [_ | remaining_defenders] = defenders,
        continue_fn \\ &continue/1
      ) do
    result
    |> case do
      :attacker_wins -> {attackers, remaining_defenders}
      :defender_wins -> {remaining_attackers, defenders}
      :tie -> {attackers, defenders}
    end
    |> continue_fn.()
  end

  @spec continue({[Formation.t()], [Formation.t()]}, fun) ::
          {:attacker_wins | :defender_wins, [Formation.t()]}
  def continue(units, perform_fn \\ &perform/2)
  def continue({[], defenders}, _), do: {:defender_wins, defenders}
  def continue({attackers, []}, _), do: {:attacker_wins, attackers}
  def continue({attackers, defenders}, perform_fn), do: perform_fn.(attackers, defenders)

  defp find_winner(attack_val, defense_val) do
    cond do
      attack_val > defense_val -> :attacker_wins
      attack_val < defense_val -> :defender_wins
      true -> :tie
    end
  end

  defp d12, do: :rand.uniform(12)
end
