defmodule Stripe.Plan do
  @moduledoc """
  This module gives access the the Stripe Plan API.

  https://stripe.com/docs/api#plans

  Stripe.Plan provides `list`, `retrieve`, `create`, `update`, and `delete`
  
  ## Example
    attrs = HashDict.new([
      id: "new_plan",
      name: "New Plan",
      amount: 1000,
      currency: "USD",
      interval: "week"
    ])

    { :ok, plan } = Stripe.Plan.create(attrs)

    id = HashDict.get(plan, id)
  """

  @base "https://api.stripe.com/v1/plans"

  use Stripe.Resource
end
