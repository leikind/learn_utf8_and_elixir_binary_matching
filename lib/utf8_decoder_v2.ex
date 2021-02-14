defmodule Utf8DecoderV2 do
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
end
