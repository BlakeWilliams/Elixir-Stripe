defmodule Stripe.CustomerResource do
  defmacro __using__(_) do
    quote do
      use Stripe.URI
      use Stripe.CustomerResource.Create
      use Stripe.CustomerResource.Delete
      use Stripe.CustomerResource.List
      use Stripe.CustomerResource.Retrieve
      use Stripe.CustomerResource.Update


      def build_customer_url(customer_id, ext \\ "") do
        if ext != "", do: ext = "/" <> ext

        @base <> "/#{customer_id}/#{@resource}" <> ext
      end
    end
  end
end
