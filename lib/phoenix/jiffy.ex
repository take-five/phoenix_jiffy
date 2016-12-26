defmodule Phoenix.Jiffy do
  @moduledoc """
  JSON engine replacement for Phoenix.Controller.

  Serializes Ecto.Date, Ecto.Time and Ecto.DateTime to strings
  and then calls Jiffy encoder.

  ## Usage

  In config/config.exs:

    config :phoenix, :format_encoders,
      json: Phoenix.Jiffy
  """

  @engine :jiffy
  @encode_options [:use_nil]
  @decode_options [:use_nil, :return_maps]

  alias Phoenix.Jiffy.TimeEncoder

  @doc false
  @spec encode(any, opts :: List.t) :: {:ok, any()}
  def encode(value, opts \\ []) do
    {:ok, encode!(value, opts)}
  end

  @doc false
  @spec encode!(any, opts :: List.t) :: any()
  def encode!(value, opts \\ []) do
    value
    |> TimeEncoder.encode()
    |> @engine.encode(@encode_options ++ opts)
  end

  @doc false
  @spec decode(String.t, opts :: List.t) ::
    {:ok, any()} |
    {:error, atom()}
  def decode(value, opts \\ []) do
    try do
      {:ok, @engine.decode(value, @decode_options ++ opts)}
    catch
      error -> error
    end
  end

  @doc false
  @spec decode!(String.t, opts :: List.t) :: any() | no_return()
  def decode!(value, opts \\ []) do
    try do
      @engine.decode(value, @decode_options ++ opts)
    catch
      _ -> raise ArgumentError
    end
  end

  @doc false
  @spec encode_to_iodata(any(), opts :: List.t) :: {:ok, charlist()}
  def encode_to_iodata(value, opts \\ []) do
    {:ok, encode_to_iodata!(value, opts)}
  end

  @doc false
  @spec encode_to_iodata!(any(), opts :: List.t) :: charlist()
  def encode_to_iodata!(value, opts \\ []) do
    to_charlist(encode!(value, opts))
  end
end
