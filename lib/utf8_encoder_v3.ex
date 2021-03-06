defmodule Utf8EncoderV3 do
  @moduledoc false

  def codepoints_to_utf8(list_of_codepoints) do
    list_of_codepoints
    |> Enum.reduce(<<>>, fn codepoint, binary ->
      binary <> codepoint_to_binary(codepoint)
    end)
  end

  # 0xxxxxxx  <== a single byte
  def codepoint_to_binary(codepoint) when codepoint > 31 and codepoint <= 0b01111111 do
    <<codepoint::integer()-size(8)>>
  end

  # 110xxxxx 10xxxxxx <== a leading byte + 1 continuation byte
  # The biggest integer we can fit is 11 bits: 0b11111111111
  # def codepoint_to_binary(codepoint) when codepoint > 0b01111111 and codepoint <= 0b11111111111 do
  def codepoint_to_binary(codepoint) when codepoint <= 0b11111111111 do
    <<five_bits::size(5), six_bits::size(6)>> = <<codepoint::size(11)>>

    <<0b110::size(3), five_bits::size(5), 0b10::size(2), six_bits::size(6)>>
  end

  # 1110xxxx 10xxxxxx 10xxxxxx <== a leading byte + 2 continuation byte
  # The biggest integer we can fit is 16 bits
  def codepoint_to_binary(codepoint) when codepoint <= 0b1111111111111111 do
    <<four_bits::size(4), six_bits::size(6), six_bits2::size(6)>> = <<codepoint::size(16)>>

    <<0b1110::size(4), four_bits::size(4), 0b10::size(2), six_bits::size(6), 0b10::size(2),
      six_bits2::size(6)>>
  end
end
