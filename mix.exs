defmodule Stripe.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripe,
      version: "0.0.1",
      name: "Stripe",
      source_url: "https://github.com/BlakeWilliams/Elixir-Stripe",
      homepage_url: "https://github.com/BlakeWilliams/Elixir-Stripe",
      elixir: "~> 0.12.4",
      deps: deps(Mix.env)
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [ :httpotion ]
    ]
  end

  # Returns the list of development dependencies
  defp deps(:dev) do
    deps(:prod) ++
    [
      { :exvcr, github: "parroty/exvcr" },
    ]
  end

  defp deps(:test) do
    deps(:dev)
  end

  # Returns the list of production dependencies
  defp deps(:prod) do
    [
      { :httpotion, github: "myfreeweb/httpotion" },
      { :json, github: "cblage/elixir-json" }
    ]
  end
end
