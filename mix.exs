defmodule JiffyEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :jiffy_ex,
      version: "0.1.0",
      elixir: "~> 1.8",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      name: "JiffyEx",
      source_url: "https://github.com/coby-spotim/jiffy_ex",
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      # The main page in the docs
      docs: [main: "JiffyEx", extras: ["README.md"]],
      dialyzer: [plt_add_deps: :transitive]
    ]
  end

  def application do
    [
      extra_applications: applications(Mix.env())
    ]
  end

  defp applications(:dev), do: applications(:all) ++ [:remixed_remix]
  defp applications(_all), do: [:logger, :runtime_tools]

  def deps do
    [
      ## Package Requirements
      {:jiffy, ">= 0.0.0"},
      ## Testing and Development Dependencies
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:credo, "~> 1.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:remixed_remix, "~> 1.0.0", only: :dev}
    ]
  end

  defp package do
    [
      description: "Elixir module that wraps the Erlang Jiffy package",
      # These are the default files included in the package
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Coby Benveniste"],
      links: %{"GitHub" => "https://github.com/coby-spotim/jiffy_ex"},
      licenses: ["MIT License"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
