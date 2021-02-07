defmodule UTF8Test do
  use ExUnit.Case, async: true

  @moduledoc """

  #####  The genius of UTF8 #####

  0xxxxxxx
  110xxxxx 10xxxxxx
  1110xxxx 10xxxxxx 10xxxxxx
  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

  * Backward compatibility
  * Single bytes (0xxxxxxx), leading bytes (11xxxxxx), and continuation bytes (10xxxxxx) do not share values,
    in other word, it is impossible to confuse a leafing byte with a continuation byte or a single byte
  * The number of high-order 1's in the leading byte of a multi-byte sequence indicates the number of bytes in the sequence.
  """

  test "valid UTF8" do
    bytes = [
      # п
      0b11010000,
      0b10111111,
      # р
      0b11010001,
      0b10000000,
      # и
      0b11010000,
      0b10111000,
      # в
      0b11010000,
      0b10110010,
      # е
      0b11010000,
      0b10110101,
      # т
      0b11010001,
      0b10000010,
      # space
      0b00100000,
      # U
      0b01010101,
      # S
      0b01010011,
      # A
      0b01000001,
      # space
      0b00100000,
      # 愛
      0b11100110,
      0b10000100,
      0b10011011,
      0b10011011
    ]

    assert UTF8.valid?(bytes)
    assert UTF8.extract_utf(bytes) == "привет USA 愛"
  end

  test "some invalid bitstring is not UTF8" do
    bytes = [0b10110010, 0b10111010, 0b10110010, 0b10110011]
    assert !UTF8.valid?(bytes)
  end

  # test "find unicode codepoints among garbage" do
  #   bytes = [
  #     0b00000000,
  #     # п
  #     0b11010000,
  #     0b10111111,
  #     0b00000000,
  #     # р
  #     0b11010001,
  #     0b10000000,
  #     # и
  #     0b11010000,
  #     0b10111000,
  #     0b10100000,
  #     # в
  #     0b11010000,
  #     0b10110010,
  #     # е
  #     0b11010000,
  #     0b10110101,
  #     # т
  #     0b11010001,
  #     0b10000010,
  #     # space
  #     0b00100000,
  #     0b10100000,
  #     # U
  #     0b01010101,
  #     # S
  #     0b01010011,
  #     0b10100000,
  #     0b10111111,
  #     # A
  #     0b01000001,
  #     # space
  #     0b00100000,
  #     0b10100000,
  #     0b10111111,
  #     # 愛
  #     0b11100110,
  #     0b10000100,
  #     0b10011011,
  #     0b10011011
  #   ]

  #   assert !UTF8.valid?(bytes)
  #   assert UTF8.extract_utf(bytes) == "привет USA 愛"
  # end
end
