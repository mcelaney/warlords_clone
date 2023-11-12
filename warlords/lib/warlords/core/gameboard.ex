defmodule Warlords.Core.Gameboard do
  @moduledoc """
  The Gameboard Context

  Gameboards involve all the parts of the game which are unique to a
  scenario. This includes everything from the arrangement of tiles on the
  gameboard to the types of armies and items available to players.
  """

  alias Warlords.Core.Gameboard.ProductionTemplate
  alias Warlords.Core.Gameboard.ArmyType
  alias Warlords.Core.Gameboard.City
  alias Warlords.Core.Gameboard.Empire
  alias Warlords.Core.Gameboard.Item
  alias Warlords.Core.Gameboard.Terrain

  defdelegate new_army_template(attrs), to: ProductionTemplate, as: :new
  defdelegate new_army_template!(attrs), to: ProductionTemplate, as: :new!

  defdelegate new_army_type(attrs), to: ArmyType, as: :new
  defdelegate new_army_type!(attrs), to: ArmyType, as: :new!

  defdelegate new_city(attrs), to: City, as: :new
  defdelegate new_city!(attrs), to: City, as: :new!

  defdelegate new_empire(attrs), to: Empire, as: :new
  defdelegate new_empire!(attrs), to: Empire, as: :new!

  defdelegate new_item(attrs), to: Item, as: :new
  defdelegate new_item!(attrs), to: Item, as: :new!

  defdelegate new_terrain(attrs), to: Terrain, as: :new
  defdelegate new_terrain!(attrs), to: Terrain, as: :new!
end
