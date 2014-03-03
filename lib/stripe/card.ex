defmodule Stripe.Card do
  @moduledoc """
  This module gives access the the Stripe Card API.

  https://stripe.com/docs/api#cards

  Stripe.Card provides `list`, `retrieve`, `create`, `update`, and `delete`.
  
  ## Example
    customer_id = "cus_abc123"
    attrs = HashDict.new([
      card: HashDict.new([
        number: 4242424242424242,
        exp_month: "02",
        exp_year: 2019
      ])
    ])

    { :ok, customer } = Stripe.Card.create(customer_id, attrs)

    id = HashDict.get(customer, id)

    Stripe.Card.delete(customer_id, id)
  """

  @base "https://api.stripe.com/v1/customers"
  @resource "cards"

  use Stripe.CustomerResource
end
