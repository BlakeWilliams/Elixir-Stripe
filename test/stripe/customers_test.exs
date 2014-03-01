defmodule StripeCustomersTest do
  use ExUnit.Case

  test "retrieve returns user" do
    id = "cus_3aDRxsZH8sTV6F"
    {:ok, customer} = Stripe.Customers.retrieve(id)

    assert HashDict.get(customer, "id") == id
  end

  test "creates a customer with passed attributes" do
    attrs = HashDict.new([
      email: "foo@bar.com",
      description: "Test User!"
      ])

    {:ok, customer} = Stripe.Customers.create(attrs)

    assert HashDict.get(customer, "email") == "foo@bar.com"
    assert HashDict.get(customer, "description") == "Test User!"
    assert HashDict.get(customer, "id") != nil
  end

  test "updates a customer with passed attributes" do
    id = create_user

    attrs = HashDict.new([
      email: "new@bar.com",
      description: "New description!"
      ])

    {:ok, customer} = Stripe.Customers.update(id, attrs)

    assert HashDict.get(customer, "email") == "new@bar.com"
    assert HashDict.get(customer, "description") == "New description!"
    assert HashDict.get(customer, "id") != nil
  end

  test "delete a customer returns okay" do
    id = create_user

    {:ok, json} = Stripe.Customers.delete(id)
    assert HashDict.get(json, "deleted") == true
  end

  test "delete an invalid id returns error" do
    id = "fake"

    {:error, _json} = Stripe.Customers.delete(id)
  end

  defp create_user(attrs \\ HashDict.new) do
    {:ok, customer} = Stripe.Customers.create(attrs)
    HashDict.get(customer, "id")
  end
end
