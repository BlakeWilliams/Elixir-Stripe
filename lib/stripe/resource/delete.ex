defmodule Stripe.Resource.Delete do
  defmacro __using__(_) do
    quote do
      @doc """
      Deletes Stripe object with passed in id
      """
      def delete(id) do
        build_url(id)
        |> Stripe.Request.delete
      end

      defoverridable [delete: 1]
    end
  end
end
