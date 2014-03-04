defmodule Stripe.Resource.Update do
  defmacro __using__(_) do
    quote do
      @doc """
      Updates Stripe object with passed in id with attributes
      """
      def update(id, attributes) do
        form_data = Stripe.URI.encode_query(attributes)

        build_url(id)
        |> Stripe.Request.post(form_data)
      end

      defoverridable [update: 2]
    end
  end
end
