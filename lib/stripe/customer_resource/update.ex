defmodule Stripe.CustomerResource.Update do
  defmacro __using__(_) do
    quote do
      def update(customer_id, id, attributes) do
        body = Stripe.URI.encode_query(attributes)

        build_customer_url(customer_id, id)
        |> Stripe.Request.post(body)
      end

      def overridable :update
    end

  end
end
