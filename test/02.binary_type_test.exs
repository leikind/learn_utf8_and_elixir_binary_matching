defmodule BinaryTypeTest do
  use ExUnit.Case, async: true

  test "a string is a binary" do
    IO.inspect("hello", binaries: :as_binaries)
  end

  test "binary type literal" do
    IO.inspect(<<104, 101, 108, 108, 111>>)
  end

  test "you can embed the string inside the binary constructor" do
    IO.inspect(<<"hello">>)
  end

  test "you can build a binary with segments" do
    <<"hel", "lo">> |> IO.inspect()
    <<"hel", 108, 111>> |> IO.inspect()
    <<"hel", 108, 0b1101111>> |> IO.inspect()
  end

  test "concatenate two binaries" do
    a = <<104, 101, 108>>
    b = <<108, 111>>

    IO.inspect(a <> b)
  end

  test "breaking the abstraction of a UTF8 string by adding a null byte" do
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

    <<12::unsigned-big-integer>> |> IO.inspect(base: :binary)
  end

  test "every segment has a type and may have arguments (2)" do
    <<"hello"::utf8>> |> IO.inspect()
    <<"hello"::utf8>> |> IO.inspect(base: :binary)
    <<"hello"::utf16>> |> IO.inspect(base: :binary)
    <<"hello"::utf32>> |> IO.inspect(base: :binary)
  end

  # Enter Unicode encodings!

  test "Unicode encodings vs Unicode codepoints" do
    [?h, ?e, ?l, ?l, ?o] |> IO.inspect(charlists: false)

    <<"hello"::utf8>> |> IO.inspect(binaries: :as_binaries)
    <<"hello"::utf16>> |> IO.inspect(binaries: :as_binaries)
    <<"hello"::utf32>> |> IO.inspect(binaries: :as_binaries)
  end

  test "Unicode encodings vs Unicode codepoints (2)" do
    [?L, ?λ, ?ლ, ?💩] |> IO.inspect(charlists: false)

    <<"Lλლ💩"::utf8>> |> IO.inspect(binaries: :as_binaries)
    <<"Lλლ💩"::utf16>> |> IO.inspect(binaries: :as_binaries)
    <<"Lλლ💩"::utf32>> |> IO.inspect(binaries: :as_binaries)
  end

  test "size and bitstrings: a bitstring is a contiguous sequence of bits in memory" do
    a = 5
    b = 17
    IO.inspect(a, base: :binary)
    IO.inspect(b, base: :binary)

    <<a::size(3), b::size(5)>> |> IO.inspect(base: :binary)
  end

  # A binary is a bitstring where the number of bits is divisible by 8.
  # every binary is a bitstring, but not every bitstring is a binary.
  test "a bitstring which is not a binary" do
    <<0b11::size(2), 0b101::size(3)>> |> IO.inspect(base: :binary)
  end
end
