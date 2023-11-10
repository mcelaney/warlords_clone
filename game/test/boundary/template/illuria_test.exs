defmodule Boundary.Template.IlluriaTest do
  use Game.DataCase

  alias Game.Boundary.Template.Illuria

  describe "Smoke Tests" do
    test "army_types/0" do
      assert Enum.count(Illuria.army_types()) > 0
    end

    test "cities/0" do
      assert Enum.count(Illuria.cities()) > 0
    end

    test "empires/0" do
      assert Enum.count(Illuria.empires()) > 0
    end

    test "items/0" do
      assert Enum.count(Illuria.items()) > 0
    end

    test "terrains/0" do
      assert Enum.count(Illuria.terrains()) > 0
    end
  end
end
