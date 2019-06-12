defmodule JiffyExTest do
  use ExUnit.Case
  doctest JiffyEx

  test "encode! - simple" do
    input = %{a: "b", c: "d"}
    expected_output = "{\"c\":\"d\",\"a\":\"b\"}"
    assert expected_output == JiffyEx.encode!(input)
  end

  test "encode - simple" do
    input = %{a: "b", c: "d"}
    expected_output = "{\"c\":\"d\",\"a\":\"b\"}"
    assert {:ok, expected_output} == JiffyEx.encode(input)
  end

  test "decode! - simple (with `return_maps`)" do
    input = "{\"c\":\"d\",\"a\":\"b\"}"
    expected_output = %{"a" => "b", "c" => "d"}
    assert expected_output == JiffyEx.decode!(input, return_maps: true)
  end

  test "decode - simple (with `return_maps`)" do
    input = "{\"c\":\"d\",\"a\":\"b\"}"
    expected_output = %{"a" => "b", "c" => "d"}
    assert {:ok, expected_output} == JiffyEx.decode(input, return_maps: true)
  end

  test "encode - raise error" do
    assert_raise ErlangError, fn -> JiffyEx.encode!(<<255>>) end
  end

  test "encode - return error tuple" do
    assert {:error, %ErlangError{original: {:invalid_string, <<255>>}}} = JiffyEx.encode(<<255>>)
  end

  test "decode - raise error" do
    assert_raise ErlangError, fn -> JiffyEx.decode!("invalid") end
  end

  test "decode - return error tuple" do
    assert {:error, %ErlangError{original: {1, :invalid_json}}} = JiffyEx.decode("invalid")
  end
end
