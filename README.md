# Geetest

Elixir toolkit for [Geetest](http://www.geetest.com)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

* Add geetest to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:geetest, "~> 0.0.1"}]
end
```

* Ensure geetest is started before your application:

```elixir
def application do
  [applications: [:geetest]]
end
```

## Usage

### Config

```elixir
config :geetest,
  id: "app-id",
  key: "app-key"
```

### Start the server

```elixir
{:ok, pid} = Geetest.start_link
```

### Register

```elixir
{:ok, challenge} = Geetest.register
```

### Validate

```elixir
{:ok} = Geetest.validate("challenge", "validate", "seccode")
```
