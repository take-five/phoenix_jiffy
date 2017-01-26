defmodule Phoenix.Jiffy.Mixfile do
  use Mix.Project

  @url_docs "http://hexdocs.pm/phoenix_jiffy"
  @url_github "https://github.com/take-five/phoenix_jiffy"

  def project do
    [app: :phoenix_jiffy,
     name: "phoenix_jiffy",
     description: "Jiffy adapter for Phoenix projects",
     version: "0.2.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: %{
       files: [
         "lib",
         "mix.exs",
         "LICENSE",
         "README.md"
       ],
       licenses: [ "MIT" ],
       links: %{
         "Docs" => @url_docs,
         "GitHub" => @url_github
       },
       maintainers: [ "Alexei Mikhailov" ]
     },
     docs: [
       extras: [ "README.md" ],
       source_ref: "master",
       source_url: @url_github
     ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :jiffy]]
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
      { :jiffy, "~> 0.14" },
      { :ex_doc, "~> 0.14", optional: true, only: [ :dev, :test ] },
      { :ecto, "~> 2.0", optional: true, only: [ :dev, :test ] }
    ]
  end
end
