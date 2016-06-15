defmodule Geetest.Mixfile do
  use Mix.Project

  def project do
    [app: :geetest,
     version: "0.0.1",
     name: "Geetest",
     description: description,
     source_url: "https://github.com/linjunpop/geetest",
     homepage_url: "https://github.com/linjunpop/geetest",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps,
     docs: [
       extras: ["README.md", ]
     ]
   ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end

  defp description do
    "Elixir toolkit for Geetest"
  end

  defp package do
    [
      name: :geetest,
      files: ["lib", "mix.exs", "README*", "LICENSE"],
      maintainers: ["Jun Lin"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/linjunpop/geetest"
      }
    ]
  end
end
