defmodule NumbersBytesCharactersTest do
  use ExUnit.Case, async: true

  # Goals:
  #
  # * Difference between Unicode and Unicode encodings
  # * How UTF-8 works
  # * Learn the power of binary/bitstring pattern matching in Erlang/Elixir
  # * We are not going into advanced topics like glyphs...

  test "how to print a number in binary numeral system" do
    IO.inspect(5, base: :binary)
    IO.inspect(12, base: :binary)
    IO.inspect(32, base: :binary)
  end

  test "a literal for a binary number" do
    IO.puts(0b101)
    IO.puts(0b1100)
  end

  # we'll use only binary numeral system for this presentation, not hex
  # easier to demonstrate binary pattern matching
  test "bytes" do
    IO.puts(0b00000101)
    IO.puts(0b00001100)
  end

  # bytes vs characters

  test "number of characters" do
    String.length("L") |> IO.puts()
    String.length("λ") |> IO.puts()
    # lasi https://en.wikipedia.org/wiki/Georgian_scripts
    String.length("ლ") |> IO.puts()
    String.length("💩") |> IO.puts()
    String.length("Lλლ💩") |> IO.puts()
  end

  # why?
  test "the number of bytes a character takes" do
    byte_size("L") |> IO.puts()
    byte_size("λ") |> IO.puts()
    byte_size("ლ") |> IO.puts()
    byte_size("💩") |> IO.puts()
  end

  test "the number of bits a character takes" do
    bit_size("L") |> IO.puts()
    bit_size("λ") |> IO.puts()
    bit_size("ლ") |> IO.puts()
    bit_size("💩") |> IO.puts()
  end
end
