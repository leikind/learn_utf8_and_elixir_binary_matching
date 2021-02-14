defmodule Utf8EncoderV1 do
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
end
