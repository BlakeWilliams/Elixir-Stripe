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

  def create_card(customer_id) do
    [do: id] = use_cassette "card helper" do

      {year, _, _} = :erlang.date
      attrs = HashDict.new([
        card: HashDict.new([
          number: 4242424242424242,
          exp_month: "02",
          exp_year: year + 1,
        ])
      ])

      {:ok, card} = Stripe.Card.create(customer_id, attrs)
    end

    id
  end
end
