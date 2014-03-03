defmodule Stripe.CustomerResource.Create do
  defmacro __using__(_) do
    quote do
      @doc """
      Creates Stripe object for customer with customer_id
      using the passed in attributes.
      """
      def create(customer_id, attributes) do
        url = build_customer_url(customer_id)
        form_data = Stripe.URI.encode_query(attributes)

        Stripe.Request.post(url, form_data)
      end

      defoverridable [create: 2]
    end

  end
end
