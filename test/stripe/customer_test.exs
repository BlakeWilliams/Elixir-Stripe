defmodule StripeCustomerTest do
  use ExUnit.Case
  use ExVCR.Mock

  setup do
    { :ok, id: TestHelper.create_customer }
  end

  test "retrieve customer" do
    use_cassette "retrieve customer" do
      { :ok, customers } = Stripe.Customer.list

      assert HashDict.get(customers, "count") > 0
    end
  end

  test "create a customer" do
    use_cassette "create customer" do
      attrs = HashDict.new([
        email: "new@bar.com",
        description: "Test User!"
      ])

      { :ok, customer } = Stripe.Customer.create(attrs)

      assert HashDict.get(customer, "email") == "new@bar.com"
      assert HashDict.get(customer, "description") == "Test User!"
      assert HashDict.get(customer, "id") != nil
    end
  end

  test "updates a customer", meta do
    use_cassette "update customer" do
      attrs = HashDict.new([
        email: "new@bar.com",
        description: "New description!"
      ])

      { :ok, customer } = Stripe.Customer.update(meta[:id], attrs)

      assert HashDict.get(customer, "email") == "new@bar.com"
      assert HashDict.get(customer, "description") == "New description!"
      assert HashDict.get(customer, "id") != nil
    end
  end

  test "delete a customer" do
    use_cassette "delete customer" do
      attrs = HashDict.new([
        email: "foo2@bar.com",
        description: "Delete User!"
      ])

      { :ok, customer } = Stripe.Customer.create(attrs)
      id = HashDict.get(customer, "id")

      { :ok, json } = Stripe.Customer.delete(id)

      assert HashDict.get(json, "deleted") == true
    end
  end

  test "delete an invalid id errors" do
    id = "fake"

    { :error, _json } = Stripe.Customer.delete(id)
  end
end
