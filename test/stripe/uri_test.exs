defmodule Stripe.URITest do
  use ExUnit.Case

  test "returns single level query params" do
    list = HashDict.new([a: 1, b: 2])

    assert Stripe.URI.encode_query(list) == "b=2&a=1"
  end

  test "returns single nested query params" do
    list = HashDict.new([a: HashDict.new([b: 1, c: 2])])

    assert Stripe.URI.encode_query(list) == "a[c]=2&a[b]=1"
  end

  test "returns double nested query params" do
    last = HashDict.new([c: 1, d: 2])
    middle = HashDict.new([b: last])
    first = HashDict.new([a: middle])

    assert Stripe.URI.encode_query(first) == "a[b][d]=2&a[b][c]=1"
  end
end
