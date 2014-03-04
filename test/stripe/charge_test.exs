defmodule Stripe.ChargeTest do
  use ExUnit.Case
  use ExVCR.Mock

  setup do
    customer_id = TestHelper.create_customer
    TestHelper.create_card(customer_id)

    { :ok, customer_id: TestHelper.create_customer }
  end

  test "list charges", meta do
    create_charge meta[:customer_id]

    use_cassette "list charges" do
      { :ok, charge } = Stripe.Charge.list

      assert HashDict.get(charge, "count") > 0
    end
  end

  test "create a charge", meta do
    use_cassette "create charge" do
      attrs = HashDict.new([
        amount: 1000,
        currency: "usd",
        customer: meta[:customer_id]
      ])

      { :ok, charge } = Stripe.Charge.create(attrs)
      assert HashDict.get(charge, "amount") == 1000
    end
  end

  test "retrieve a charge", meta do
    id = create_charge meta[:customer_id]

    use_cassette "retrieve charge" do
      { :ok, charge } = Stripe.Charge.retrieve(id)

      assert HashDict.get(charge, "id") == id
    end
  end

  test "update a charge", meta do
    id = create_charge meta[:customer_id]

    use_cassette "update charge" do
      attrs = HashDict.new([
        description: "Test!"
      ])

      { :ok, charge } = Stripe.Charge.update(id, attrs)

      assert HashDict.get(charge, "description") == "Test!"
    end
  end

  test "refund a charge", meta do
    id = create_charge meta[:customer_id]

    use_cassette "refund charge" do
      { :ok, charge } = Stripe.Charge.refund(id, [])

      assert HashDict.get(charge, "refunded") == true
    end
  end

  test "capture a charge", meta do
    use_cassette "capture charge" do
      attrs = HashDict.new([
        amount: 1000,
        currency: "usd",
        customer: meta[:customer_id],
        capture: false
      ])

      { :ok, charge } = Stripe.Charge.create(attrs)
      id = HashDict.get(charge, "id")
      assert HashDict.get(charge, "captured") == false

      { :ok, charge } = Stripe.Charge.capture(id)
      assert HashDict.get(charge, "captured") == true
    end
  end

  defp create_charge(customer_id) do
    [do: id] = use_cassette "create charge helper" do
      HTTPotion.start
      attrs = HashDict.new([
        amount: 1000,
        currency: "usd",
        customer: customer_id
      ])

      { :ok, charge } = Stripe.Charge.create(attrs)
      HashDict.get(charge, "id")
    end

    id
  end
end
