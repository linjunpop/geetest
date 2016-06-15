defmodule Geetest.Provider do
  @doc """
  Register

  Returns `{:ok, challenge}` if success, `{:error, reason}` otherwise.
  """
  @callback register() :: {:ok, String.t} | {:error, any}

  @doc """
  Validate

  Returns `{:ok}` if is valid, `{:error, reason}` otherwise
  """
  @callback validate(String.t, String.t, String.t) :: {:ok} | {:error, any}
end
