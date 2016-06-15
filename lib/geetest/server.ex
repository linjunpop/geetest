defmodule Geetest.Server do
  use GenServer

  @default_provider Geetest.Provider.Default

  @doc "Init Server"
  def init(_) do
    if has_valid_config? do
      {:ok, {}}
    else
      message = ~s(Please config geetest with `config :geetest, [id: "", key: ""]`)
      {:stop, {:shutdown, message}}
    end
  end

  @doc "Handle call"
  def handle_call({:register}, _from, state) do
    provider = get_provider

    {:reply, provider.register(), state}
  end
  def handle_call({:validate, challenge, validate, seccode}, _from, state) do
    provider = get_provider

    {:reply, provider.validate(challenge, validate, seccode), state}
  end

  defp get_provider do
    Application.get_env(:geetest, :provider) || @default_provider
  end

  defp has_valid_config? do
    Application.get_env(:geetest, :id) &&
      Application.get_env(:geetest, :key)
  end
end
