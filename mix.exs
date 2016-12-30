defmodule Mp3parser.Mixfile do
  use Mix.Project

  def project do
    [app: :mp3parser,
     version: "0.1.0",
     elixir: "~> 1.4-rc",
     escript: [main_module: CLI], #entry point of the application
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    []
  end
end
