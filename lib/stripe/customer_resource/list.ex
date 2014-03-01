defmodule Stripe.CustomerResource.List do
  defmacro __using__(_) do
    quote do
      def list(customer_id, count \\ 10) do
        build_customer_url(customer_id) <> "?count=#{count}"
        |> Stripe.Request.get()
      end

      def overridable :list
    end

  end
end
