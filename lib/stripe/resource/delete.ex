defmodule Stripe.Resource.Delete do
  defmacro __using__(_) do
    quote do
      def delete(id) do
        build_url(id)
        |> Stripe.Request.delete
      end

      def overridable :delete
    end
  end
end
