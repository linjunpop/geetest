defmodule Geetest do
  @server Geetest.Server

  @default_timeout 20000
  @timeout Application.get_env(:geetest, :timeout, @default_timeout)

  @spec start_link :: GenServer.on_start
  def start_link do
    GenServer.start_link(@server, [], name: @server)
  end

  @doc """
  Register

  Returns `{:ok, challenge}` if success, `{:error, reason}` otherwise.
  """
  @spec register(server :: GenServer.on_start) :: {:ok, String.t} | {:error, any}
  def register(server \\ @server) do
    GenServer.call(server, {:register}, @timeout)
  end

  @doc """
  Validate

  Returns `{:ok}` if is valid, `{:error, reason}` otherwise
  """
  @spec validate(challenge :: String.t, validation :: String.t, seccode :: String.t, server :: GenServer.on_start) :: {:ok} | {:error, any}
  def validate(challenge, validation, seccode, server \\ @server) do
    GenServer.call(server, {:validate, challenge, validation, seccode}, @timeout)
  end
end
