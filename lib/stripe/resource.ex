defmodule Stripe.Resource do
  defmacro __using__(_) do
    quote do
      use Stripe.URI

      use Stripe.Resource.Create
      use Stripe.Resource.Delete
      use Stripe.Resource.List
      use Stripe.Resource.Retrieve
      use Stripe.Resource.Update
    end
  end

end
