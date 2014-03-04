defmodule Stripe.TokenTest do
  use ExUnit.Case
  use ExVCR.Mock

  test "create a token" do
    use_cassette "create token" do
      { :ok, token } = Stripe.Token.create(HashDict.new([
        card: HashDict.new([
          number: 4242424242424242,
          exp_month: 12,
          exp_year: 2015,
        ])
      ]))
      
      assert HashDict.get(token, "used") == false
    end
  end

  test "retrieve a token" do
    use_cassette "retrieve token" do
      { :ok, token } = Stripe.Token.create(HashDict.new([
        card: HashDict.new([
          number: 4242424242424242,
          exp_month: 12,
          exp_year: 2015,
        ])
      ]))
      
      id = HashDict.get(token, "id")
      { :ok, token } = Stripe.Token.retrieve(id)

      assert HashDict.get(token, "id") == id
    end
  end
end
