defmodule Stripe.Charge do
  @moduledoc """
  This module gives access the the Stripe Charge API.

  https://stripe.com/docs/api#charges

  Stripe.Charge provides `list`, `retrieve`, `create`, `update`, `refund`, and
  `capture`.
  
  ## Example
    id = "cus_abc123"
    attrs = HashDict.new([
      amount: 10000,
      currency: "USD",
      customer: id
    ])

    { :ok, charge } = Stripe.Charge.create(attrs)

    id = HashDict.get(charge, id)

    Stripe.Charge.refund(charge, HashDict.new([
      amount: 100
    ])
  """

  @base "https://api.stripe.com/v1/charges"

  use Stripe.URI
  use Stripe.Resource.Create
  use Stripe.Resource.List
  use Stripe.Resource.Retrieve
  use Stripe.Resource.Update

  def refund(id, attributes) do
    form_data = Stripe.URI.encode_query(attributes)

    build_url(id) <> "/refund"
    |> Stripe.Request.post(form_data)
  end

  def capture(id, attributes \\ []) do
    form_data = Stripe.URI.encode_query(attributes)

    build_url(id) <> "/capture"
    |> Stripe.Request.post(form_data)
  end
end
