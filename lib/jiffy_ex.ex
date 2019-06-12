defmodule JiffyEx do
  @moduledoc """
  An Elixir module that wraps the Erlang jiffy library.

  Provides `encode!/1`, `encode!/2`, `encode/1`, `encode/2`, `decode!/1`, `decode!/2`, `decode/1`, `decode/2` functions for encoding and decoding JSON values.

  *Note: The jiffy functions by default all raise exceptions, so by definition the `encode!` and `decode!` functions will be faster as they are not wrapped in try/rescue clauses in order to catch any errors that come out of the jiffy library.*
  """

  alias JiffyEx.Opts

  @doc """
  Generates a JSON encoded string of the input term.

  Same as `encode/2` but raises an exception on errors.
  """
  @spec encode!(term, Keyword.t()) :: String.t() | no_return
  def encode!(value, opts \\ []) do
    opts = Opts.parse_encode_opts(opts)
    :jiffy.encode(value, opts)
  end

  @doc """
  Parses the JSON input into an Elixir term.

  Same as `decode/2` but raises an exception on errors.
  """
  @spec decode!(iodata, Keyword.t()) :: term | {:has_trailer, term, iodata} | no_return
  def decode!(value, opts \\ []) do
    opts = Opts.parse_decode_opts(opts)
    :jiffy.decode(value, opts)
  end

  @doc """
  Generates a JSON encoded string of the input term.

  ## Options
  - `:uescape` - (defaults to `false`) Tells jiffy to escape UTF-8 sequences and produce 7-bit clean output.
  - `:pretty` - (defaults to `false`) Tells jiffy to produce JSON using two-space indentation.
  - `:force_utf8` - (defaults to `false`) Tells jiffy to force strings to encode as UTF-8 by fixing broken surrogate pairs
  and/or using the replacement character to remove broken UTF-8 sequences in data.
  - `:use_nil` - (defaults to `false`) Tells jiffy to encode any instances of `nil` as `null` in the JSON output.
  - `:escape_forward_slashes` - (defaults to `false`) Tells jiffy to escape the forward slash (`/`) character which can be useful when encoding URLs in some cases.
  - `:bytes_per_red` - A jiffy option that controls the number of bytes that jiffy will process as an equivalent to a reduction.
  Each 20 reductions jiffy consumes 1% of our allocated time slice for the current process.
  - `:bytes_per_iter` - A jiffy option for backwards compatible option that is converted into the `bytes_per_red` value.
  """
  @spec encode(term, Keyword.t()) :: {:ok, String.t()} | {:error, Exception.t()}
  def encode(value, opts \\ []) do
    {:ok, encode!(value, opts)}
  rescue
    exception -> {:error, exception}
  end

  @doc """
  Parses the JSON input into an Elixir term.

  ## Options
  - `:return_maps` - (defaults to `false`) Tells jiffy to return maps instead of jiffy's default tuple of a list of tuples.
  - `:null_term` - (defaults to `:null`) Tells jiffy to use the specified term instead of `:null` when decoding JSON. If not set, then `:null` is returned.
  - `:use_nil` - (defaults to `false`) Tells jiffy to return `nil` instead of `:null` when decoding the JSON. Equivalent to setting `null_term: nil`.
  - `:return_trailer` - (defaults to `false`) Tells jiffy that if any non-whitespace is found after the first JSON term is decoded the return value becomes
  `{:has_trailer, first_decoded_term, rest_of_the_iodata}. This is useful to decode multiple terms in a single binary.
  - `:dedupe_keys` - (defaults to `false`) Tells jiffy to ensure that the if there are duplicated keys in a JSON object, the decoded term will only contain one
  entry with that key. The last value seen will be taken.
  - `:copy_strings` - (defaults to `false`) When strings are decoded in Erlang, they are created as sub-binaries of the input data, which forces the BEAM VM to keep
  references to the original input and keeping the original input in memory, sometimes causing leaks. Setting this option will force the decoding process to create
  new binaries for the decoded strings, so that the original input can be properly garbage collected after decoding the result.
  - `:bytes_per_red` - A jiffy option that controls the number of bytes that jiffy will process as an equivalent to a reduction.
  Each 20 reductions jiffy consumes 1% of our allocated time slice for the current process.
  - `:bytes_per_iter` - A jiffy option for backwards compatible option that is converted into the `bytes_per_red` value.
  """
  @spec decode(iodata, Keyword.t()) ::
          {:ok, term | {:has_trailer, term, iodata}} | {:error, Exception.t()}
  def decode(value, opts \\ []) do
    {:ok, decode!(value, opts)}
  rescue
    exception -> {:error, exception}
  end
end
