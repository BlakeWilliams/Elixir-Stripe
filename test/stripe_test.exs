defmodule StripeTest do
  use ExUnit.Case

  test "set_secret sets the secret" do
    old_secret = Stripe.get_secret
    Stripe.set_secret "Secret!"

    assert Stripe.get_secret == "Secret!"

    Stripe.set_secret(old_secret)
  end
end
