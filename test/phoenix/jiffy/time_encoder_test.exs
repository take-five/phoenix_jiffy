defmodule Phoenix.Jiffy.TimeEncoderTest do
  use ExUnit.Case, async: true

  alias Phoenix.Jiffy.TimeEncoder

  @date Ecto.Date.utc()
  @date_time Ecto.DateTime.utc()
  @time Ecto.Time.utc()

  test "converts Ecto.{Date, DateTime, Time} to ISO 8601 format" do
    assert TimeEncoder.encode(@date) == Ecto.Date.to_iso8601(@date)
    assert TimeEncoder.encode(@date_time) == Ecto.DateTime.to_iso8601(@date_time)
    assert TimeEncoder.encode(@time) == Ecto.Time.to_iso8601(@time)
  end

  test "recursively converts lists, maps and structs" do
    map = %{
      "key" => "value",
      "date" => @date,
      "date_time" => @date_time,
      "time" => @time,
      "list" => [
        @date, @date_time, @time
      ]
    }

    assert TimeEncoder.encode(map) == %{
      "key" => "value",
      "date" => Ecto.Date.to_iso8601(@date),
      "date_time" => Ecto.DateTime.to_iso8601(@date_time),
      "time" => Ecto.Time.to_iso8601(@time),
      "list" => [
        Ecto.Date.to_iso8601(@date),
        Ecto.DateTime.to_iso8601(@date_time),
        Ecto.Time.to_iso8601(@time)
      ]
    }
  end
end
