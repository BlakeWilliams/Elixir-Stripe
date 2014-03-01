defmodule Stripe.CustomerResource.Create do
  defmacro __using__(_) do
    quote do
      def create(customer_id, attributes) do
        url = build_customer_url(customer_id)
        form_data = Stripe.URI.encode_query(attributes)

        Stripe.Request.post(url, form_data)
      end

      def overridable :create
    end

  end
end
