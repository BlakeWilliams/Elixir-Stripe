defmodule Stripe.CustomerResource.Delete do
  defmacro __using__(_) do
    quote do
      def delete(customer_id, id) do
        build_customer_url(customer_id, id)
        |> Stripe.Request.delete()
      end

      def overridable :delete
    end

  end
end
