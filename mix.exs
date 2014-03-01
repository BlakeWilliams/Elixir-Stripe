defmodule Stripe.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripe,
      version: "0.0.1",
      elixir: "~> 0.12.4",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [ :httpotion ]
    ]
  end

  # Returns the list of dependencies in the format:
  defp deps do
    [
      { :httpotion, github: "myfreeweb/httpotion" },
      { :json, github: "cblage/elixir-json" }
    ]
  end
end
