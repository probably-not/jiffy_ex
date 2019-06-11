defmodule JiffyEx do
  @moduledoc """
  An Elixir module that wraps the Erlang jiffy library.
  """

  alias JiffyEx.Opts

  @spec encode!(term, Keyword.t()) :: String.t() | no_return
  def encode!(value, opts \\ []) do
    opts = Opts.parse_encode_opts(opts)
    :jiffy.encode(value, opts)
  end

  @spec decode!(iodata, Keyword.t()) :: term | no_return
  def decode!(value, opts \\ []) do
    opts = Opts.parse_decode_opts(opts)
    :jiffy.decode(value, opts)
  end

  @spec encode(term, Keyword.t()) :: {:ok, String.t()} | {:error, Exception.t()}
  def encode(value, opts \\ []) do
    {:ok, encode!(value, opts)}
  rescue
    exception -> {:error, exception}
  end

  @spec decode(iodata, Keyword.t()) :: {:ok, term} | {:error, Exception.t()}
  def decode(value, opts \\ []) do
    {:ok, decode!(value, opts)}
  rescue
    exception -> {:error, exception}
  end
end
