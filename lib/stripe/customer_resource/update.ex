defmodule Stripe.CustomerResource.Update do
  defmacro __using__(_) do
    quote do
      @doc """
      Updates Stripe object for customer with customer_id
      with passed in id and attributes
      """
      def update(customer_id, id, attributes) do
        body = Stripe.URI.encode_query(attributes)

        build_customer_url(customer_id, id)
        |> Stripe.Request.post(body)
      end

      defoverridable [update: 3]
    end

  end
end
