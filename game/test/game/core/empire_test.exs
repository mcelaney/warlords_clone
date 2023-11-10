defmodule Game.Core.EmpireTest do
  use Game.DataCase
  alias Game.Core.Empire

  doctest Empire

  @valied_attrs %{id: :horse_lords, label: "Horse Lords"}
  @required_fields ~w(id label)a

  describe "new/1" do
    test "with valid attributes" do
      {:ok, %Empire{} = result} = Empire.new(@valied_attrs)
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
    end

    test "with invalid attributes returns an changeset" do
      assert {:error, %Ecto.Changeset{}} = Empire.new(%{})
    end

    test "requires fields" do
      for field <- @required_fields do
        {:error, changeset} = Empire.new(Map.delete(@valied_attrs, field))
        expected = %{field => ["can't be blank"]}
        assert expected == errors_on(changeset)
      end
    end
  end

  describe "new!/1" do
    test "with valid attributes" do
      result = Empire.new!(@valied_attrs)
      assert %Empire{} = result
      assert result.id == @valied_attrs[:id]
      assert result.label == @valied_attrs[:label]
    end

    test "with invalid attributes raises" do
      assert_raise RuntimeError, fn ->
        Empire.new!(%{})
      end
    end
  end
end
