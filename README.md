# Jiffex

An Elixir Module that wraps the Erlang jiffy library.

Provides `encode!/1`, `encode!/2`, `encode/1`, `encode/2`, `decode!/1`, `decode!/2`, `decode/1`, `decode/2` functions for encoding and decoding JSON values.

**NOTE: The jiffy functions by default all raise exceptions, so by definition the `encode!` and `decode!` functions will be faster as they are not wrapped in try/rescue clauses in order to catch any errors that come out of the jiffy library.**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `jiffex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:jiffex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/jiffex](https://hexdocs.pm/jiffex).
