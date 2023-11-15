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
  alias Warlords.Core.Gameboard.Ruin
  alias Warlords.Core.Gameboard.Terrain
  alias Warlords.Core.Gameboard.Tile
  alias Warlords.Core.Gameboard.Tower

  defdelegate new_army_template(attrs), to: ProductionTemplate, as: :new
  defdelegate new_army_template!(attrs), to: ProductionTemplate, as: :new!

  defdelegate new_army_type(attrs), to: ArmyType, as: :new
  defdelegate new_army_type!(attrs), to: ArmyType, as: :new!

  defdelegate new_city(attrs), to: City, as: :new
  defdelegate new_city!(attrs), to: City, as: :new!

  defdelegate upgradeable?(city), to: City
  defdelegate upgrade_city(city), to: City, as: :upgrade
  defdelegate defense_modifier(city), to: City

  defdelegate new_empire(attrs), to: Empire, as: :new
  defdelegate new_empire!(attrs), to: Empire, as: :new!

  defdelegate new_item(attrs), to: Item, as: :new
  defdelegate new_item!(attrs), to: Item, as: :new!

  defdelegate new_ruin(attrs), to: Ruin, as: :new
  defdelegate new_ruin!(attrs), to: Ruin, as: :new!

  defdelegate new_terrain(attrs), to: Terrain, as: :new
  defdelegate new_terrain!(attrs), to: Terrain, as: :new!

  defdelegate new_tile(attrs), to: Tile, as: :new
  defdelegate new_tile!(attrs), to: Tile, as: :new!

  defdelegate new_tower, to: Tower, as: :new
  defdelegate new_tower!, to: Tower, as: :new!
  defdelegate new_tower(attrs), to: Tower, as: :new
  defdelegate new_tower!(attrs), to: Tower, as: :new!

  defdelegate add_stack_to_tile(tile, stack), to: Tile, as: :add_stack
end
