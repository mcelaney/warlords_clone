defmodule Warlords.Core.City do
  @moduledoc """
  The city context
  """

  alias Warlords.Core.City.Army

  defdelegate produce_army(attrs), to: Army, as: :new
  defdelegate produce_army!(attrs), to: Army, as: :new!
end
