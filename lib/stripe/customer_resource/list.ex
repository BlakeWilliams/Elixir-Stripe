defmodule Stripe.CustomerResource.List do
  defmacro __using__(_) do
    quote do
      @doc """
      Lists Stripe objects for customer with customer_id
      with a default count of 10
      """
      def list(customer_id, count \\ 10) do
        build_customer_url(customer_id) <> "?count=#{count}"
        |> Stripe.Request.get()
      end

      defoverridable [list: 2]
    end

  end
end
