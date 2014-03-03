defmodule Stripe do
  use Application.Behaviour

  @ets_table :stripe_config

  @doc """
  Sets the secret key for your Stripe accounts API access.
  Your Stripe keys can be retrieved from https://manage.stripe.com/account/apikeys
  """
  def set_secret(value) do
    setup
    :ets.insert(@ets_table, {:secret, value})
  end

  @doc """
  Retrieves the secret key for your Stripe account
  """
  def get_secret do
    setup
    secret = :ets.lookup(@ets_table, :secret)[:secret]

    if secret == nil, do: raise StripeError.new "Call Stripe.set_secret first"
    secret
  end

  defp setup do
    if :ets.info(@ets_table) == :undefined do
      :ets.new(@ets_table, [:set, :public, :named_table])
    end
  end
end
