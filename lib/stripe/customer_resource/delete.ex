defmodule Stripe.CustomerResource.Delete do
  defmacro __using__(_) do
    quote do
      @doc """
      Deletes Stripe object for customer with customer_id
      using the passed in id
      """
      def delete(customer_id, id) do
        build_customer_url(customer_id, id)
        |> Stripe.Request.delete()
      end

      defoverridable [delete: 2]
    end

  end
end
