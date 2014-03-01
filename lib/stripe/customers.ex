defmodule Stripe.Customers do
  import HashDict, only: [get: 2]

  def retrieve(id) do
    url = build_url(id)

    Stripe.Request.get(url)
  end

  def create(attributes) do
    form_data = URI.encode_query(attributes)

    Stripe.Request.post(build_url, form_data)
  end

  def update(id, attributes) do
    url = build_url(id)
    form_data = URI.encode_query(attributes)

    Stripe.Request.post(url, form_data)
  end

  def delete(id) do
    url = build_url(id)

    Stripe.Request.delete(url)
  end

  defp build_url(ext \\ "") do
    unless ext == "" do
      ext = "/" <> ext
    end

    "https://api.stripe.com/v1/customers#{ext}"
  end
end
