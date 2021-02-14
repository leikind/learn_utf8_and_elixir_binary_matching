defmodule Utf8DecoderV4 do
  @moduledoc false

  def utf8_to_codepoints(bitstring) do
    utf8_to_codepoints(bitstring, [])
  end

  defp utf8_to_codepoints(<<>>, codepoints) do
    Enum.reverse(codepoints)
  end

  # 0xxxxxxx
  defp utf8_to_codepoints(
         <<0b0::size(1), ascii_char::integer-size(7), rest::bitstring>>,
         codepoints
       ) do
    new_codepoints = [ascii_char | codepoints]
    utf8_to_codepoints(rest, new_codepoints)
  end

  # 110xxxxx 10xxxxxx
  defp utf8_to_codepoints(
         <<0b110::size(3), seg1::integer-size(5), 0b10::size(2), seg2::integer-size(6),
           rest::bitstring>>,
         codepoints
       ) do
    <<codepoint::integer-size(11)>> = <<seg1::integer-size(5), seg2::integer-size(6)>>

    new_codepoints = [codepoint | codepoints]
    utf8_to_codepoints(rest, new_codepoints)
  end

  # 1110xxxx 10xxxxxx 10xxxxxx
  defp utf8_to_codepoints(
         <<0b1110::size(4), seg1::integer-size(4), 0b10::size(2), seg2::integer-size(6),
           0b10::size(2), seg3::integer-size(6), rest::bitstring>>,
         codepoints
       ) do
    <<codepoint::integer-size(16)>> =
      <<seg1::integer-size(4), seg2::integer-size(6), seg3::integer-size(6)>>

    new_codepoints = [codepoint | codepoints]
    utf8_to_codepoints(rest, new_codepoints)
  end

  # 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
  defp utf8_to_codepoints(
         <<0b11110::size(5), seg1::integer-size(3), 0b10::size(2), seg2::integer-size(6),
           0b10::size(2), seg3::integer-size(6), 0b10::size(2), seg4::integer-size(6),
           rest::bitstring>>,
         codepoints
       ) do
    <<codepoint::integer-size(21)>> =
      <<seg1::integer-size(3), seg2::integer-size(6), seg3::integer-size(6),
        seg4::integer-size(6)>>

    new_codepoints = [codepoint | codepoints]
    utf8_to_codepoints(rest, new_codepoints)
  end
end
