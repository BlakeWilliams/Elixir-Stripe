defmodule Stripe.Card do
  @base "https://api.stripe.com/v1/customers"
  @resource "cards"

  use Stripe.CustomerResource
end
