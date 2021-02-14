defmodule Utf8DecoderV1 do
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
end
