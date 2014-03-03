defmodule Stripe.Resource.Create do
  defmacro __using__(_) do
    quote do
      @doc """
      Creates Stripe object with passed in attributes
      """
      def create(attributes) do
        form_data = URI.encode_query(attributes)

        Stripe.Request.post(build_url, form_data)
      end

      defoverridable [create: 1]
    end
  end
end
