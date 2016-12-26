# Phoenix.Jiffy

JSON Engine replacement for Phoenix. Mimics default JSON engine (`Poison`), but uses
[Jiffy](https://github.com/davisp/jiffy) under the hood.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `phoenix_jiffy` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:phoenix_jiffy, "~> 0.1.0"}]
    end
    ```

  2. Ensure `phoenix_jiffy` is started before your application:

    ```elixir
    def application do
      [applications: [:phoenix_jiffy]]
    end
    ```

  3. Add to `config/config.exs`:
  
    ```elixir
    config :phoenix, :format_encoders,
      json: Phoenix.Jiffy
    ```

  4. Change your `endpoint.ex`:
  
    ```elixir
    defmodule MyApp.Endpoint do
      use Phoenix.Endpoint, otp_app: :my_app
    
      ...
    
      plug Plug.Parsers,
        parsers: [:urlencoded, :multipart, :json],
        pass: ["*/*"],
        json_decoder: Phoenix.Jiffy
        
      ...
      
    end
    ```
