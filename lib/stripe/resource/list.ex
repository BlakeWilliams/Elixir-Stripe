defmodule Stripe.Resource.List do
  defmacro __using__(_) do
    quote do
      @doc """
      Lists Stripe objects with default count of 10
      """
      def list(count \\ 10) do
        build_url() <> "?count=#{count}"
        |> Stripe.Request.get
      end

      defoverridable [list: 1]
    end
  end
end
