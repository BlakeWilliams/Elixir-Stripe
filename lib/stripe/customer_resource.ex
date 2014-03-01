defmodule Stripe.CustomerResource do
  defmacro __using__(_) do
    quote do
      use Stripe.URI
      use Stripe.CustomerResource.Create
      use Stripe.CustomerResource.Delete
      use Stripe.CustomerResource.List
      use Stripe.CustomerResource.Retrieve
      use Stripe.CustomerResource.Update
    end
  end
end
