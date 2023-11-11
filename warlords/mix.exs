defmodule Warlords.MixProject do
  use Mix.Project

  def project do
    [
      app: :warlords,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "Warlords Warlords",
      docs: [
        extras: ["README.md"],
        groups_for_modules: [
          "Boundary - Maps": [
            Warlords.Boundary.Template.Maps.Illuria
          ],
          "Core - City Concerns": [
            Warlords.Core.City,
            Warlords.Core.City.Army,
            Warlords.Core.City.Army.Label
          ],
          "Core - Map Concerns": [
            Warlords.Core.Gameboard,
            Warlords.Core.Gameboard.ArmyTemplate,
            Warlords.Core.Gameboard.ArmyType,
            Warlords.Core.Gameboard.City,
            Warlords.Core.Gameboard.Empire,
            Warlords.Core.Gameboard.Item,
            Warlords.Core.Gameboard.Terrain
          ],
          Boilerplate: [
            Ecto.Atom
          ]
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Warlords.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:makeup_html, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
