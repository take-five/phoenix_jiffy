defmodule Phoenix.Jiffy.TimeEncoder do
  @moduledoc ~S"""
  Converts Ecto.Date, Ecto.Time and Ecto.DateTime objects to
  formatted strings (ISO 8601). Can recursively convert maps and lists.

  TimeEncoder is used to prepare data for JSON encoding when JSON engine
  is not default (Poison) and doesn't support encoding of Ecto objects.

  ## Examples

    iex> now = Ecto.DateTime.utc
    #Ecto.DateTime<2016-12-24 14:57:30>

    iex> Phoenix.Jiffy.TimeEncoder.encode(now)
    "2016-12-24T14:57:30"

    iex> Phoenix.Jiffy.TimeEncoder.encode(%{now: now})
    %{now: "2016-12-24T14:57:30"}

    iex> Phoenix.Jiffy.TimeEncoder.encode([now])
    ["2016-12-24T14:57:30"]

    iex> now |> Phoenix.Jiffy.TimeEncode.encode() |> Phoenix.Jiffy.encode()
    "\"2016-12-24T14:57:30\""
  """

  @spec encode(List.t) :: List.t
  def encode(value) when is_list(value) do
    Enum.map(value, &encode/1)
  end

  @spec encode(Ecto.Date.t | Ecto.Time.t | Ecto.DateTime.t) :: String.t
  def encode(time = %{__struct__: type}) when type in [Ecto.Date, Ecto.Time, Ecto.DateTime] do
    type.to_iso8601(time)
  end

  @spec encode(Map.t) :: Map.t
  def encode(value) when is_map(value) do
    value
    |> Map.to_list()
    |> Enum.reduce(%{}, fn {attr, value}, acc ->
      Map.put(acc, attr, encode(value))
    end)
  end

  @spec encode(any) :: any
  def encode(value), do: value
end
