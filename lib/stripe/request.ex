defmodule Stripe.Request do
  @moduledoc """
  This module is a thin layer on top of HTTPotion. Its main purpose is to
  pass the `Authorization` header to Stripe.
  """
  alias HTTPotion.Response

  @doc "Send a GET request to url"
  def get(url) do
    HTTPotion.get(url, auth_header)
    |> parse_response
  end

  @doc "Send a POST request to url with body"
  def post(url, body) do
    HTTPotion.post(url, body, auth_header)
    |> parse_response
  end

  @doc "Send a DELETE request url"
  def delete(url) do
    HTTPotion.delete(url, auth_header)
    |> parse_response
  end

  defp parse_response(response) do
    Response[body: body, status_code: status, headers: _headers] = response

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
