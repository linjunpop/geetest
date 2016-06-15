defmodule Geetest.Provider.Default do
  @moduledoc """
  Service for geetest.com
  """
  @behaviour Geetest.Provider

  @api_server "http://api.geetest.com/"

  def register do
    url = @api_server <> "register.php"

    params = [
      {"gt", id},
      {"sdk", "Elixir"}
    ]

    case HTTPoison.get(url, [], params: params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, calculate_hash(body <> key)}
      {:ok, %HTTPoison.Response{status_code: 403}} ->
        {:error, "Your key and ID might be incorrect"}
      {:error, reason} ->
        {:error, reason}
    end
  end

  def validate(challenge, validation, seccode) do
    md5 = calculate_hash(key <> "geetest" <> challenge)

    case md5 do
      ^validation -> validate_with_remote_server(seccode)
      _ -> {:error, "mismatch of challenge and validation strings"}
    end
  end

  defp validate_with_remote_server(seccode) do
    url = @api_server <> "validate.php"
    md5 = calculate_hash(seccode)

    request_body = {
      :form,
      [
        {"seccode", seccode}
      ]
    }

    case HTTPoison.post(url, request_body) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case body do
          ^md5 -> {:ok}
          _ -> {:error, "invalid seccode"}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp calculate_hash(value) do
    :crypto.hash(:md5, value)
    |> Base.encode16(case: :lower)
  end

  defp id do
    Application.get_env(:geetest, :id)
  end

  defp key do
    Application.get_env(:geetest, :key)
  end
end


