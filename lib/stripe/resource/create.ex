defmodule Stripe.Resource.Create do
  defmacro __using__(_) do
    quote do
      def create(attributes) do
        form_data = URI.encode_query(attributes)

        Stripe.Request.post(build_url, form_data)
      end

      def overridable :create
    end
  end
end
