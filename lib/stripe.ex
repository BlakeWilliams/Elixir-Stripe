defmodule Stripe do
  use Application.Behaviour

  @ets_table :stripe_config

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Stripe.Supervisor.start_link
  end

  def setup do
    if :ets.info(@ets_table) == :undefined do
      :ets.new(@ets_table, [:set, :public, :named_table])
    end
  end

  def set_secret(value) do
    setup
    :ets.insert(@ets_table, {:secret, value})
  end

  def get_secret do
    setup
    secret = :ets.lookup(@ets_table, :secret)[:secret]

    if secret == nil, do: raise StripeError.new "Call Stripe.set_secret first"
    secret
  end
end
