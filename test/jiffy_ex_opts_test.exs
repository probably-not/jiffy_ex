defmodule JiffyExOptsTest do
  use ExUnit.Case
  alias JiffyEx.Opts
  doctest Opts

  test "parse decode opts - all true" do
    opts = [
      return_maps: true,
      use_nil: true,
      return_trailer: true,
      dedup_keys: true,
      copy_strings: true,
      null_term: "undefined",
      bytes_per_iter: 10,
      bytes_per_red: 10
    ]

    jiffy_opts = [
      :return_maps,
      :use_nil,
      :return_trailer,
      :dedup_keys,
      :copy_strings,
      {:null_term, "undefined"},
      {:bytes_per_iter, 10},
      {:bytes_per_red, 10}
    ]

    assert Opts.parse_decode_opts(opts) == jiffy_opts
  end

  test "parse decode opts - all false" do
    opts = [
      return_maps: false,
      use_nil: false,
      return_trailer: false,
      dedup_keys: false,
      copy_strings: false,
      null_term: "undefined",
      bytes_per_iter: 10,
      bytes_per_red: 10
    ]

    jiffy_opts = [{:null_term, "undefined"}, {:bytes_per_iter, 10}, {:bytes_per_red, 10}]

    assert Opts.parse_decode_opts(opts) == jiffy_opts
  end

  test "parse decode opts - mixed" do
    opts = [
      return_maps: true,
      use_nil: true,
      return_trailer: false,
      dedup_keys: false,
      copy_strings: true,
      bytes_per_red: 10
    ]

    jiffy_opts = [
      :return_maps,
      :use_nil,
      :copy_strings,
      {:bytes_per_red, 10}
    ]

    assert Opts.parse_decode_opts(opts) == jiffy_opts
  end

  test "parse decode opts - with invalid to filter out" do
    opts = [return_maps: true, use_nil: true, random_opt: true]
    jiffy_opts = [:return_maps, :use_nil]
    assert Opts.parse_decode_opts(opts) == jiffy_opts
  end

  test "parse decode opts - only invalid" do
    opts = [random_opt: true]
    jiffy_opts = []
    assert Opts.parse_decode_opts(opts) == jiffy_opts
  end

  test "parse encode opts - all true" do
    opts = [
      uescape: true,
      pretty: true,
      force_utf8: true,
      use_nil: true,
      escape_forward_slashes: true,
      bytes_per_iter: 10,
      bytes_per_red: 10
    ]

    jiffy_opts = [
      :uescape,
      :pretty,
      :force_utf8,
      :use_nil,
      :escape_forward_slashes,
      {:bytes_per_iter, 10},
      {:bytes_per_red, 10}
    ]

    assert Opts.parse_encode_opts(opts) == jiffy_opts
  end

  test "parse encode opts - all false" do
    opts = [
      uescape: false,
      pretty: false,
      force_utf8: false,
      use_nil: false,
      escape_forward_slashes: false,
      bytes_per_iter: 10,
      bytes_per_red: 10
    ]

    jiffy_opts = [{:bytes_per_iter, 10}, {:bytes_per_red, 10}]

    assert Opts.parse_encode_opts(opts) == jiffy_opts
  end

  test "parse encode opts - mixed" do
    opts = [
      uescape: true,
      pretty: false,
      force_utf8: true,
      use_nil: false,
      escape_forward_slashes: false,
      bytes_per_red: 10
    ]

    jiffy_opts = [:uescape, :force_utf8, {:bytes_per_red, 10}]

    assert Opts.parse_encode_opts(opts) == jiffy_opts
  end

  test "parse encode opts - with invalid to filter out" do
    opts = [uescape: true, pretty: true, random_opt: true]
    jiffy_opts = [:uescape, :pretty]
    assert Opts.parse_encode_opts(opts) == jiffy_opts
  end

  test "parse encode opts - only invalid" do
    opts = [random_opt: true]
    jiffy_opts = []
    assert Opts.parse_encode_opts(opts) == jiffy_opts
  end
end
