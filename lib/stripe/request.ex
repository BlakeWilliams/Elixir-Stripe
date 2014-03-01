defmodule Stripe.Request do
  alias HTTPotion.Response

  def get(url) do
    response = HTTPotion.get(url, auth_header)
    |> parse_response
  end

  def post(url, body) do
    response = HTTPotion.post(url, body, auth_header)
    |> parse_response
  end

  def delete(url, headers \\ []) do
    HTTPotion.delete(url, auth_header)
    |> parse_response
  end

  defp parse_response(response) do
    Response[body: body, status_code: status, headers: headers] = response

    {:ok, json} = JSON.decode(body)

    if status in 200..299 do
      {:ok, json}
    else
      {:error, json}
    end
  end

  defp auth_header do
    ["Authorization": "Bearer #{Stripe.get_secret}"]
  end
end
