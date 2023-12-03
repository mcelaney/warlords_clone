defmodule Warlords.Core.Units.Label do
  @moduledoc """
  Helper to build labels for armies
  """
  alias Warlords.Core.Gameboard.City
  alias Warlords.Core.Units.Hero
  alias Warlords.Core.Units.Special
  alias Warlords.Core.Units.Standard

  @typedoc """
  A label in the form of "City Nth Type" ex. "Gildenhome 101st Elven Archers"
  """
  @type t :: String.t()

  @doc """
  Builds a label for the given attributes

  ## Examples

      iex> Warlords.Core.Units.Label.build("Elven Archers", "Gildenhome", 11)
      "Gildenhome 11th Elven Archers"
  """
  @spec build(String.t(), String.t(), non_neg_integer()) :: t()
  def build(type_label, city_label, nth) do
    [
      city_label,
      nth_label(nth),
      type_label
    ]
    |> Enum.join(" ")
  end

  @doc """
  Given a unit, optionally renames it

  - Special units are never renamed.
  - Heros get a name from a list in the template.
  - Standard units get a name based on the city and the number of units produced.
  """
  @spec maybe_rename(Hero.t() | Special.t() | Standard.t(), template :: module(), City.t()) ::
          Hero.t() | Special.t() | Standard.t()
  def maybe_rename(%Hero{} = hero, template, _city) do
    template.unit_template.knight_names() |> Enum.random() |> update_label(hero)
  end

  def maybe_rename(%Special{} = unit, _template, _city), do: unit

  def maybe_rename(%Standard{label: label} = unit, _template, %{
        label: city,
        production_count: nth
      }) do
    label |> build(city, nth) |> update_label(unit)
  end

  defp nth_label(nth) when is_integer(nth), do: "#{nth}#{ordinal_suffix(nth)}"
  defp nth_label(_), do: ""

  defp ordinal_suffix(i) when i > 0 do
    cond do
      rem(i, 100) in 4..20 -> "th"
      rem(i, 10) == 1 -> "st"
      rem(i, 10) == 2 -> "nd"
      rem(i, 10) == 3 -> "rd"
      true -> "th"
    end
  end

  defp update_label(new_label, hero) do
    %{hero | label: new_label}
  end
end
