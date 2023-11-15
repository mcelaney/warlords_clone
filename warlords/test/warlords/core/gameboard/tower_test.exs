defmodule Warlords.Core.Gameboard.TowerTest do
  use Warlords.DataCase
  alias Warlords.Core.Gameboard
  alias Warlords.Core.Gameboard.Tower

  doctest Tower

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Tower{} = result} = Gameboard.new_tower(%{})
      assert result.defense == 1

      {:ok, %Tower{} = result} = Gameboard.new_tower()
      assert result.defense == 1
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      %Tower{} = result = Gameboard.new_tower!(%{})
      assert result.defense == 1

      %Tower{} = result = Gameboard.new_tower!()
      assert result.defense == 1
    end
  end
end
