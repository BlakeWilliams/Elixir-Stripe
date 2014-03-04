defmodule Stripe.Customer do
  @moduledoc """
  This module gives access the the Stripe Customer API.

  https://stripe.com/docs/api#customers

  Stripe.Customer provides `list`, `retrieve`, `create`, `update`, and `delete`.
  
  ## Example
    attrs = HashDict.new([
      email: "new@bar.com",
      description: "Test User!"
    ])

    { :ok, customer } = Stripe.Customer.create(attrs)

    id = HashDict.get(customer, "id")

    Stripe.Customer.delete(id)
  """

  @base "https://api.stripe.com/v1/customers"

  use Stripe.Resource
end
