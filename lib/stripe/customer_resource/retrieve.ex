defmodule Stripe.CustomerResource.Retrieve do
  defmacro __using__(_) do
    quote do
      @doc """
      Retrieves Stripe object for customer with customer_id
      with passed in id
      """
      def retrieve(customer_id, id) do
        build_customer_url(customer_id, id)
        |> Stripe.Request.get()
      end

      defoverridable [retrieve: 2]
    end

  end
end
