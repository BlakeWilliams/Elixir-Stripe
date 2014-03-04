defmodule Stripe.CardTest do
  use ExUnit.Case
  use ExVCR.Mock

  setup do
    { :ok, customer_id: TestHelper.create_customer }
  end

  test "list cards", meta do
    create_card meta[:customer_id]

    use_cassette "list cards" do
      {:ok, cards} = Stripe.Card.list(meta[:customer_id], 5)

      assert HashDict.get(cards, "count") > 0
    end
  end

  test "create a card", meta do
    use_cassette "create card" do
      {:ok, card} = Stripe.Card.create(meta[:customer_id], card_attrs)
      assert HashDict.get(card, "last4") == "4242"
    end
  end

  test "retrieve a card", meta do
    id = create_card meta[:customer_id]
    use_cassette "retrieve card" do

      {:ok, card} = Stripe.Card.retrieve(meta[:customer_id], id)
      assert HashDict.get(card, "last4") == "4242"
    end
  end

  test "delete a card", meta do
    use_cassette "delete card" do
      {:ok, card} = Stripe.Card.create(meta[:customer_id], card_attrs)
      id = HashDict.get(card, "id")

      {:ok, card} = Stripe.Card.delete(meta[:customer_id], id)
      assert HashDict.get(card, "deleted") == true
    end
  end


  test "update a card", meta do
    id = create_card meta[:customer_id]

    use_cassette "delete card" do
      {year, _, _} = :erlang.date
      attrs = HashDict.new([
        exp_year: year + 5
      ])

      {:ok, card} = Stripe.Card.update(meta[:customer_id], id, attrs)
      assert HashDict.get(card, "exp_year") == year + 5
    end
  end

  defp card_attrs do
    {year, _, _} = :erlang.date
    attrs = HashDict.new([
      number: 4242424242424242,
      exp_month: "02",
      exp_year: year + 1,
    ])

    HashDict.new([card: attrs])
  end

  defp create_card(customer_id) do
    [do: id] = use_cassette "create card helper" do
      {:ok, card} = Stripe.Card.create(customer_id, card_attrs)
      HashDict.get(card, "id")
    end

    id
  end

end
