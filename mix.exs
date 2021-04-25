defmodule Fpanel.MixProject do
  use Mix.Project

  def project do
    [
      app: :fpanel,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: { TUI, [] },
      extra_applications: [:httpoison, :logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ratatouille, "~> 0.5.1"},
      {:httpoison, "~> 1.8"},
      {:poison, "~> 3.1"}
    ]
  end
end
