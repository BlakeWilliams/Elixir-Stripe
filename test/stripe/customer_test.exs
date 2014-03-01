defmodule StripeCustomerTest do
  use ExUnit.Case

  test "retrieve customer" do
    create_customer
    {:ok, customers} = Stripe.Customer.list

    assert HashDict.get(customers, "count") > 0
  end

  test "create a customer" do
    attrs = HashDict.new([
      email: "foo@bar.com",
      description: "Test User!"
      ])

    {:ok, customer} = Stripe.Customer.create(attrs)

    assert HashDict.get(customer, "email") == "foo@bar.com"
    assert HashDict.get(customer, "description") == "Test User!"
    assert HashDict.get(customer, "id") != nil
  end

  test "updates a customer" do
    id = create_customer

    attrs = HashDict.new([
      email: "new@bar.com",
      description: "New description!"
      ])

    {:ok, customer} = Stripe.Customer.update(id, attrs)

    assert HashDict.get(customer, "email") == "new@bar.com"
    assert HashDict.get(customer, "description") == "New description!"
    assert HashDict.get(customer, "id") != nil
  end

  test "delete a customer" do
    id = create_customer

    {:ok, json} = Stripe.Customer.delete(id)
    assert HashDict.get(json, "deleted") == true
  end

  test "delete an invalid id errors" do
    id = "fake"

    {:error, _json} = Stripe.Customer.delete(id)
  end

  defp create_customer(attrs \\ HashDict.new) do
    {:ok, customer} = Stripe.Customer.create(attrs)
    HashDict.get(customer, "id")
  end
end
