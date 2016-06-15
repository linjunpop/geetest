defmodule Geetest.Provider.Test do
  @moduledoc """
  Service for test usage
  """

  @behaviour Geetest.Provider

  def register do
    {:ok, "test-challenge"}
  end

  def validate(_challenge, _validation, _seccode) do
    {:ok}
  end
end
