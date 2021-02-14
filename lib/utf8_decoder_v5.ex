defmodule Utf8DecoderV5 do
  def utf8_to_codepoints(bitstring) do
    with {:ok, codepoints} <- utf8_to_codepoints(bitstring, []) do
      Enum.reverse(codepoints)
    end
  end

  def utf8_to_codepoints(<<>>, codepoints) do
    {:ok, codepoints}
  end

  # 0xxxxxxx
  def utf8_to_codepoints(
        <<0b0::size(1), ascii_char::integer-size(7), rest::bitstring>>,
        codepoints
      ) do
    utf8_to_codepoints(rest, [ascii_char | codepoints])
  end

  # 110xxxxx 10xxxxxx
  def utf8_to_codepoints(
        <<0b110::size(3), seg1::integer-size(5), 0b10::size(2), seg2::integer-size(6),
          rest::bitstring>>,
        codepoints
      ) do
    <<codepoint::integer-size(11)>> = <<seg1::integer-size(5), seg2::integer-size(6)>>

    utf8_to_codepoints(rest, [codepoint | codepoints])
  end

  # 1110xxxx 10xxxxxx 10xxxxxx
  def utf8_to_codepoints(
        <<0b1110::size(4), seg1::integer-size(4), 0b10::size(2), seg2::integer-size(6),
          0b10::size(2), seg3::integer-size(6), rest::bitstring>>,
        codepoints
      ) do
    <<codepoint::integer-size(16)>> =
      <<seg1::integer-size(4), seg2::integer-size(6), seg3::integer-size(6)>>

    utf8_to_codepoints(rest, [codepoint | codepoints])
  end

  # 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
  def utf8_to_codepoints(
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

  def utf8_to_codepoints(_, _) do
    :not_utf8
  end
end
