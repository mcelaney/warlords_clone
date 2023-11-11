defmodule Warlords.Core.City.Army.Label do
  @moduledoc """
  Helper to build labels for armies
  """

  @typedoc """
  A count of produced units for use in creating a label
  """
  @type nth_count :: integer

  @typedoc """
  A label in the form of "City Nth Type" ex. "Gildenhome 101st Elven Archers"
  """
  @type t :: String.t()

  @doc """
  Builds a label for the given attributes

  ## Examples

      iex> Warlords.Core.City.Army.Label.build("Elven Archers", %{city: "Gildenhome", nth: 11})
      "Gildenhome 11th Elven Archers"
  """
  @spec build(String.t(), map) :: t()
  def build(type_label, attrs) do
    [
      city_label(attrs),
      nth_label(attrs),
      type_label
    ]
    |> Enum.join(" ")
  end

  defp city_label(attrs), do: attrs[:city] || attrs["city"]

  defp nth_label(attrs) do
    case attrs[:nth] || attrs["nth"] do
      nil -> nil
      num -> "#{num}#{ordinal_suffix(num)}"
    end
  end

  defp ordinal_suffix(i) when i > 0 do
    if rem(i, 100) in 4..20 do
      "th"
    else
      case rem(i, 10) do
        1 -> "st"
        2 -> "nd"
        3 -> "rd"
        _ -> "th"
      end
    end
  end
end
