defmodule BinaryTypeTest do
  use ExUnit.Case, async: true

  test "bitstring type" do
    IO.inspect(<<0, 0x1, 0x10, 3>>)
  end

  test "a string in Elixir is also binary encoded as UTF-8" do
    IO.inspect("hello")
    IO.inspect("hello", binaries: :as_binaries)
  end

  test "if a binary is a valid UTF-8 sequence..." do
    IO.inspect(<<104, 101, 108, 108, 111>>)
  end

  test "you can embed the string inside the binary constructor" do
    IO.inspect(<<"hello">>)
  end

  test "you can build a binary with segments (1)" do
    <<"hel", "lo">> |> IO.inspect()
  end

  test "you can build a binary with segments (2)" do
    <<"hel", 108, 111>> |> IO.inspect()
  end

  test "you can build a binary with segments (3)" do
    <<"hel", 108, 0b1101111>> |> IO.inspect()
  end

  test "concatenate two binaries" do
    a = <<104, 101, 108>>
    b = <<108, 111>>

    IO.inspect(a <> b)
  end

  test "make a UTF-8 encoded string invalid by adding a null byte" do
    "hello" |> IO.inspect()
    ("hello" <> <<0>>) |> IO.inspect()
  end

  # https://hexdocs.pm/elixir/Kernel.SpecialForms.html#%3C%3C%3E%3E/1
  test "every segment has a type and may have arguments" do
    <<104, 101, 108, 108, 111>> |> IO.inspect()
    <<104::integer, 101::integer, 108::integer, 108::integer, 111::integer>> |> IO.inspect()

    <<104::integer-size(8), 101::integer-size(8), 108::integer-size(8), 108::integer-size(8),
      111::integer-size(8)>>
    |> IO.inspect()

    <<12::unsigned-integer>> |> IO.inspect(base: :binary)
  end

  test "every segment has a type and may have arguments (2)" do
    <<"hello"::utf8>> |> IO.inspect()
    <<"hello"::utf8>> |> IO.inspect(base: :binary)
    <<"hello"::utf16>> |> IO.inspect(base: :binary)
    <<"hello"::utf32>> |> IO.inspect(base: :binary)
  end

  test "size and bitstrings: a bitstring is a contiguous sequence of bits in memory" do
    a = 5
    b = 17
    IO.inspect(a, base: :binary)
    IO.inspect(b, base: :binary)

    <<a::size(3), b::size(5)>> |> IO.inspect(base: :binary)
  end
end
