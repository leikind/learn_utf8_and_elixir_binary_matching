defmodule BasicsTest do
  use ExUnit.Case, async: true

  test "printing a number binary numeral system with inspect" do
    inspect(5, base: :binary) |> IO.puts()
    inspect(12, base: :binary) |> IO.puts()
  end

  test "printing a number binary numeral system with inspect Integer.to_string" do
    Integer.to_string(5, 2) |> IO.puts()
    Integer.to_string(12, 2) |> IO.puts()
  end

  test "a literal for a binary number" do
    IO.puts(0b101)
    IO.puts(0b1100)
  end

  test "bytes" do
    IO.puts(0b00000101)
    IO.puts(0b00001100)
  end

  # bytes vs characters

  test "the number of characters (actually graphemes)" do
    String.length("L") |> IO.puts()
    String.length("λ") |> IO.puts()
    String.length("ლ") |> IO.puts()
    String.length("💩") |> IO.puts()
  end

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

  # Enter Unicode codepoints!

  # https://en.wikipedia.org/wiki/List_of_Unicode_characters#Greek_and_Coptic
  test "Unicode codepoints" do
    ?L |> IO.puts()
    ?λ |> IO.puts()
    ?ლ |> IO.puts()
    ?💩 |> IO.puts()
  end
end
