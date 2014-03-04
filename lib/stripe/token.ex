defmodule Stripe.Token do
  @moduledoc """
  This module gives access the the Stripe Token API.

  https://stripe.com/docs/api#tokens

  Stripe.Token provides `retrieve` and `create`
  
  ## Example
    { :ok, token } = Stripe.Token.create(HashDict.new([
      card: HashDict.new([
        number: 4242424242424242,
        exp_month: 12,
        exp_year: 2015,
      ])
    ]))
  """

  @base "https://api.stripe.com/v1/tokens"

  use Stripe.URI
  use Stripe.Resource.Create
  use Stripe.Resource.Retrieve
end
