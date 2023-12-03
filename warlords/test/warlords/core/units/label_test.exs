defmodule Warlords.Core.Units.LabelTest do
  use ExUnit.Case, async: true
  import Warlords.GameboardFixtures
  import Warlords.UnitFixtures
  alias Warlords.Core.Units.Label

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

  describe "build/3" do
    test "ordinal_suffix/1 returns the expected amount" do
      for {i, expected} <- @expected do
        result = Label.build("Elven Archers", "Gildenhome", i)
        assert "Gildenhome #{expected} Elven Archers" == result
      end
    end
  end

  describe "maybe_rename/3" do
    test "maybe_rename/3 renames a hero" do
      hero = hero_fixture(%{label: "New Hero"})
      template = Warlords.Mock.Template
      city = city_fixture(%{label: "Philly", production_count: 20})

      [expected | _] = Warlords.Mock.UnitTemplate.knight_names()

      assert expected == Label.maybe_rename(hero, template, city).label
    end

    test "maybe_rename/3 does not rename a special" do
      special = special_fixture(%{label: "Dragon Riders"})
      template = Warlords.Mock.Template
      city = city_fixture(%{label: "Philly", production_count: 20})

      assert "Dragon Riders" == Label.maybe_rename(special, template, city).label
    end

    test "maybe_rename/3 renames a standard" do
      standard = standard_fixture(%{label: "Angry Elmos"})
      template = Warlords.Mock.Template
      city = city_fixture(%{label: "Philly", production_count: 20})

      assert "Philly 20th Angry Elmos" == Label.maybe_rename(standard, template, city).label
    end
  end
end
