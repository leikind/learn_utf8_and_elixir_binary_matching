defmodule MatchingBinariesTest do
  use ExUnit.Case, async: true

  test "a string in Elixir is a UTF-8 encoded binary" do
    byte_size("λ") |> IO.puts()

    <<first_byte::size(8), second_byte::size(8)>> = "λ"
    IO.puts(first_byte)
    IO.puts(second_byte)
  end

  test "If you only want to match the first byte (1)" do
    <<first_byte::size(8), _rest::bitstring>> = "λ"
    IO.puts(first_byte)
  end

  test "If you only want to match the first byte (2)" do
    byte_size("ლ") |> IO.puts()
    <<first_byte::size(8), _two_bytes_here::bitstring>> = "ლ"

    IO.puts(first_byte)
  end

  test "get bits out of a byte" do
    <<first_three::size(3), rest::size(5)>> = <<0b10100001>>

    IO.inspect(first_three, base: :binary)
    IO.inspect(rest, base: :binary)
  end

  # === pre-Unicode age: 1 byte == 1 character
  #
  # ASCII is from the pre-Unicode age when all characters had to fit in one byte
  # ASCII is punctuation and basic Latin characters
  # ASCII is in the first half of all possible numbers in a byte beginning with 32 (0b100000)
  # first half of the byte:
  # 0b00000001 -> 0b01111111
  # ASCII:
  # 0b00100000 -> 0b01111111
  #         32 ->        127

  test "Detect ASCII" do
    is_ascii_char? = fn
      <<0b0::size(1), _rest::size(7)>> -> true
      _ -> false
    end

    is_ascii_char?.("a") |> IO.inspect()
    is_ascii_char?.("A") |> IO.inspect()
    is_ascii_char?.("z") |> IO.inspect()
    is_ascii_char?.("A") |> IO.inspect()
    is_ascii_char?.("!") |> IO.inspect()
    is_ascii_char?.(<<0b10100001>>) |> IO.inspect()
    is_ascii_char?.("λ") |> IO.inspect()
    is_ascii_char?.("ლ") |> IO.inspect()
    is_ascii_char?.("💩") |> IO.inspect()
  end

  test "numbers below 32 are not characters" do
    is_ascii_char? = fn
      <<0b0::size(1), rest::size(7)>> when rest > 31 -> true
      _ -> false
    end

    is_ascii_char?.(<<0b00000000>>) |> IO.inspect()
    is_ascii_char?.(<<0b00000001>>) |> IO.inspect()
    is_ascii_char?.(" ") |> IO.inspect()
    is_ascii_char?.("a") |> IO.inspect()
  end
end
