defmodule GeetestTest do
  use ExUnit.Case, async: true
  doctest Geetest

  setup tags do
    if tags[:has_config] do
      Application.put_env(:geetest, :id, "id")
      Application.put_env(:geetest, :key, "key")
    end

    on_exit fn ->
      Application.delete_env(:geetest, :id)
      Application.delete_env(:geetest, :key)
      Application.delete_env(:geetest, :provider)
    end

    {:ok, %{}}
  end

  test "start without config key & id" do
    assert {:error, pid} = Geetest.start_link
  end

  @tag :has_config
  test "register and get challenge" do
    {:ok, _pid} = Geetest.start_link
    assert {:ok, challenge} = Geetest.register()
  end

  @tag :has_config
  test "register with test provider" do
    Application.put_env(:geetest, :provider, Geetest.Provider.Test)
    {:ok, _pid} = Geetest.start_link
    assert {:ok, "test-challenge"} = Geetest.register()
  end

  @tag :has_config
  test "validate" do
    {:ok, _pid} = Geetest.start_link
    assert {:ok} = Geetest.validate("d9793c5f1959cb5ce3fae8dec304d2d76f", "d9793c5f1959cb5ce3fae8dec304d2d76f", "d9793c5f1959cb5ce3fae8dec304d2d76f")
  end

  @tag :has_config
  test "validate with test provider" do
    Application.put_env(:geetest, :provider, Geetest.Provider.Test)
    {:ok, _pid} = Geetest.start_link
    assert {:ok} = Geetest.validate("1", "1", "1")
  end
end
