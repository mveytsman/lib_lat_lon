defmodule LibLatLon.MixProject do
  use Mix.Project

  @app :lib_lat_lon
  @app_name "LibLatLon"
  @version "0.6.1"

  def project do
    [
      app: @app,
      name: @app_name,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      description: description(),
      docs: docs(),
      xref: [exclude: []],
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        quality: :ci,
        "quality.ci": :ci,
        coveralls: :ci,
        "coveralls.detail": :ci,
        "coveralls.post": :ci,
        "coveralls.html": :ci
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: ~w|logger httpoison porcelain|a,
      mod: {LibLatLon.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.5"},
      {:jason, "~> 1.0"},
      {:porcelain, "~> 2.0"},
      {:exexif, "~> 0.0", only: [:ci]},
      {:credo, "~> 1.0", only: [:dev, :ci]},
      {:inch_ex, ">= 0.0.0", only: [:dev, :docs]},
      {:ex_doc, ">= 0.0.0", only: [:ci, :docs]},
      {:excoveralls, "~> 0.8", only: [:test, :ci]},
      {:dialyxir, "~> 1.0", only: [:dev, :ci], runtime: false}
    ]
  end

  defp aliases do
    [
      quality: ["format", "credo --strict", "dialyzer"],
      "quality.ci": [
        "format --check-formatted",
        "credo --strict",
        "dialyzer --halt-exit-status"
      ]
    ]
  end

  defp description do
    """
    Small library for direct/reverse geocoding.

    Supports explicit latitude/longitude pairs, addresses as binaries,
      as well as jpeg/tiff images having a GPS information in exif.
    """
  end

  defp package do
    [
      name: :lib_lat_lon,
      files: ~w|lib mix.exs README.md|,
      maintainers: ["Aleksei Matiushkin"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/amotion-city/#{@app}",
        "Docs" => "https://hexdocs.pm/#{@app}"
      }
    ]
  end

  defp docs() do
    [
      main: @app_name,
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/#{@app}",
      logo: "stuff/images/logo.png",
      source_url: "https://github.com/amotion-city/#{@app}",
      extras: [
        "stuff/pages/intro.md"
      ],
      groups_for_modules: [
        # LibLatLon,
        # LibLatLon.Provider

        "Data Representation": [
          LibLatLon.Bounds,
          LibLatLon.Coords,
          LibLatLon.Info
        ],
        Providers: [
          LibLatLon.Providers.GoogleMaps,
          LibLatLon.Providers.OpenStreetMap
        ]
      ]
    ]
  end
end
