defmodule Stripe.Resource.Retrieve do
  defmacro __using__(_) do
    quote do
      @doc """
      Retrieves Stripe object with id of id
      """
      def retrieve(id) do
        build_url(id)
        |> Stripe.Request.get
      end

      defoverridable [retrieve: 1]
    end
  end
end
