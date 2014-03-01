defmodule StripeCardTest do
  use ExUnit.Case

  test "list cards" do
    customer_id = create_customer
    create_card(customer_id)

    {:ok, cards} = Stripe.Card.list(customer_id, 5)

    assert HashDict.get(cards, "count") == 1
  end

  test "create a card" do
    customer_id = create_customer

    {year, _, _} = :erlang.date

    attrs = HashDict.new([
      number: 4242424242424242,
      exp_month: "02",
      exp_year: year + 1,
      ])

    card = HashDict.new([card: attrs])
    {:ok, card} = Stripe.Card.create(customer_id, card)
    assert HashDict.get(card, "last4") == "4242"
  end

  test "retreive a card" do
    customer_id = create_customer
    id = create_card(customer_id)

    {:ok, card} = Stripe.Card.retrieve(customer_id, id)
    assert HashDict.get(card, "last4") == "4242"
  end

  test "delete a card" do
    customer_id = create_customer
    id = create_card(customer_id)

    {:ok, card} = Stripe.Card.delete(customer_id, id)
    assert HashDict.get(card, "deleted") == true
  end


  test "update a card" do
    customer_id = create_customer
    id = create_card(customer_id)

    {year, _, _} = :erlang.date
    attrs = HashDict.new([
      exp_year: year + 5
    ])

    {:ok, card} = Stripe.Card.update(customer_id, id, attrs)
    assert HashDict.get(card, "exp_year") == year + 5
  end

  defp create_card(customer_id) do
    {year, _, _} = :erlang.date
    attrs = HashDict.new([
      number: 4242424242424242,
      exp_month: "02",
      exp_year: year + 1,
    ])

    card = HashDict.new([card: attrs])
    {:ok, card} = Stripe.Card.create(customer_id, card)
    HashDict.get(card, "id")
  end

  defp create_customer do
    {:ok, customer} = Stripe.Customer.create(HashDict.new)
    HashDict.get(customer , "id")
  end
end
