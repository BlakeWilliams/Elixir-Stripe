secret = System.get_env("STRIPE_SECRET_KEY")
Stripe.set_secret(secret)

ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
ExVCR.Config.filter_sensitive_data("sk_test.*", "API_KEY")

ExUnit.start

defmodule TestHelper do
  use ExVCR.Mock

  def create_customer do
    [do: id] = use_cassette "customer helper" do

      { :ok, customer } = Stripe.Customer.create(HashDict.new)
      HashDict.get(customer , "id")
    end

    id
  end
end
