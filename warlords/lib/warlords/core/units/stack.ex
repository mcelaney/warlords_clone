defmodule Warlords.Core.Units.Stack do
  @moduledoc """
  A stack of units on the gameboard
  """

  alias Warlords.Core
  alias Warlords.Core.Units.Hero
  alias Warlords.Core.Units.Special
  alias Warlords.Core.Units.Standard

  @type t :: %__MODULE__{
          empire_key: Core.empire_key(),
          units: [Hero.t() | Special.t() | Standard.t()]
        }

  @max_stack_size 8

  @enforce_keys [:empire_key, :units]
  defstruct [
    :empire_key,
    units: []
  ]

  @doc """
  Merge two stacks together

  If the number of units after the merge would be more than the maximum stack
  size it returns an error

  ## Examples

      iex> left_stack = %Warlords.Core.Units.Stack{units: [%Warlords.Core.Units.Standard{label: "Gildenhome 1st Elven Archers"}]}
      ...> right_stack = %Warlords.Core.Units.Stack{units: [%Warlords.Core.Units.Standard{label: "Gildenhome 2nd Elven Archers"}]}
      ...> Warlords.Core.Units.Stack.merge(left_stack, right_stack)

      {:ok, %Warlords.Core.Units.Stack{units: [
        %Warlords.Core.Units.Standard{label: "Gildenhome 1st Elven Archers"},
        %Warlords.Core.Units.Standard{label: "Gildenhome 2nd Elven Archers"}
      ]}}
  """
  @spec merge(t(), t()) :: {:ok, t()} | {:error, String.t()}
  def merge(%{empire_key: empire, units: left}, %{empire_key: empire, units: right}) do
    case Enum.count(left) + Enum.count(right) < @max_stack_size do
      true -> {:ok, %__MODULE__{empire_key: empire, units: left ++ right}}
      false -> {:error, "Stack can only have up to 8 units"}
    end
  end
end
