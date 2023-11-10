defmodule Warlords.Core.Gameboard.Empire do
  @moduledoc """
  The character identity of a player in the warlords.

  Each empire starts with it's capital city, a hero, and optionally a set of
  armies. Each empire has unique stat modifiers which are meant to favor a style
  of warlordsplay.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @typedoc """
  An atom used to reference a specific empire, e.g. :grey_dwarves, :selentines
  """
  @type empire_id :: Ecto.Atom

  @type t :: %__MODULE__{
          id: empire_id(),
          label: String.t()
        }

  @primary_key false
  embedded_schema do
    field(:id, Ecto.Atom)
    field(:label, :string)
  end

  @doc """
  Generates a new empire from the given attributes

  ## Examples

      iex> Warlords.Core.Gameboard.Empire.new(%{
      ...>   id: :storm_giants,
      ...>   label: "Storm Giants"
      ...> })

      %Warlords.Core.Gameboard.Empire{id: :storm_giants, label: "Storm Giants"}
  """
  @spec new!(attrs :: map) :: t() | no_return()
  def new!(attrs) do
    with {:ok, empire} <- new(attrs) do
      empire
    else
      {:error, changeset} ->
        raise "Failed to create empire: #{inspect(changeset.errors)}"
    end
  end

  @doc """
  Generates a new empire from the given attributes returned as a tagged tuple

  ## Examples

      iex> Warlords.Core.Gameboard.Empire.new(%{
      ...>   id: :storm_giants,
      ...>   label: "Storm Giants"
      ...> })

      {
        :ok,
        %Warlords.Core.Gameboard.Empire{id: :storm_giants, label: "Storm Giants"}
      }
  """
  @spec new(attrs :: map) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Ecto.Changeset.apply_action(:new_empire)
  end

  @fields ~w(id label)a
  defp changeset(empire, attrs) do
    empire
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
