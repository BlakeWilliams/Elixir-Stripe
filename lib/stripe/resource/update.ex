defmodule Stripe.Resource.Update do
  defmacro __using__(_) do
    quote do
      def update(id, attributes) do
        form_data = URI.encode_query(attributes)

        build_url(id)
        |> Stripe.Request.post(form_data)
      end

      def overridable :update
    end
  end
end
