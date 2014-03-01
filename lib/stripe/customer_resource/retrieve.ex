defmodule Stripe.CustomerResource.Retrieve do
  defmacro __using__(_) do
    quote do
      def retrieve(customer_id, id) do
        build_customer_url(customer_id, id)
        |> Stripe.Request.get()
      end

      def overridable :retrieve
    end

  end
end
