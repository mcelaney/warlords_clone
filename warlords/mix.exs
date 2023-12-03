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
          "Core - Battle Concerns": [
            Warlords.Core.Battle,
            Warlords.Core.Battle.Defense,
            Warlords.Core.Battle.Attack,
            Warlords.Core.Battle.Formation,
            Warlords.Core.Battle.StackModifier
          ],
          "Core - Units": [
            Warlords.Core.Units,
            Warlords.Core.Units.Standard,
            Warlords.Core.Units.Special,
            Warlords.Core.Units.Hero,
            Warlords.Core.Units.Stack,
            Warlords.Core.Units.Label
          ],
          "Core - Map Concerns": [
            Warlords.Core.Gameboard,
            Warlords.Core.Gameboard.Artifact,
            Warlords.Core.Gameboard.City,
            Warlords.Core.Gameboard.Empire,
            Warlords.Core.Gameboard.Quest,
            Warlords.Core.Gameboard.Tile
          ],
          Templates: [
            Template.Illuria,
            Template.Illuria.Cities,
            Template.Illuria.Plot,
            Template.Illuria.Quests,
            Template.Illuria.Units
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
  defp elixirc_paths(:dev), do: ["lib", "priv/templates"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:makeup_html, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
