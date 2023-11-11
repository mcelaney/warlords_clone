defmodule Warlords.Core.City.Army.LabelTest do
  use Warlords.DataCase
  alias Warlords.Core.City.Army.Label

  doctest Label

  @expected [
    {1, "1st"},
    {2, "2nd"},
    {3, "3rd"},
    {4, "4th"},
    {11, "11th"},
    {12, "12th"},
    {13, "13th"},
    {14, "14th"},
    {21, "21st"},
    {22, "22nd"},
    {23, "23rd"},
    {24, "24th"},
    {101, "101st"},
    {102, "102nd"},
    {103, "103rd"},
    {104, "104th"},
    {1011, "1011th"},
    {1012, "1012th"},
    {1013, "1013th"},
    {1014, "1014th"},
    {1021, "1021st"},
    {1022, "1022nd"},
    {1023, "1023rd"},
    {1024, "1024th"}
  ]

  test "ordinal_suffix/1 returns the expected amount" do
    for {i, expected} <- @expected do
      result = Warlords.Core.City.Army.Label.build("Elven Archers", %{city: "Gildenhome", nth: i})
      assert "Gildenhome #{expected} Elven Archers" == result
    end
  end
end
