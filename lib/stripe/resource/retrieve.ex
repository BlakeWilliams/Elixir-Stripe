defmodule Stripe.Resource.Retrieve do
  defmacro __using__(_) do
    quote do
      def retrieve(id) do
        build_url(id)
        |> Stripe.Request.get
      end

      def overridable :retrieve
    end
  end
end
