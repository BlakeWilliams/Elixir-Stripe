defmodule Stripe.Resource.List do
  defmacro __using__(_) do
    quote do
      def list(count \\ 10) do
        build_url() <> "?count=#{count}"
        |> Stripe.Request.get
      end

      def overridable :list
    end
  end
end
