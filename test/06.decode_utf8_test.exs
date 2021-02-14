defmodule UTF8DecodeUtf8Test do
  use ExUnit.Case, async: true

  @moduledoc """

  0xxxxxxx                                <== a single byte, 7 bits for a codepoint
  110xxxxx 10xxxxxx                       <== a leading byte + 1 continuation byte, 11 bits  for a codepoint
  1110xxxx 10xxxxxx 10xxxxxx              <== a leading byte + 2 continuation bytes, 16 bits  for a codepoint
  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx     <== a leading byte + 3 continuation bytes, 21 bits  for a codepoint

  * A leading byte defines how many continuation bytes follow
  * It is impossible to confuse a leading byte with a continuation byte
  * It is impossible to confuse a leading byte with a single byte
  * We can define border between characters easily
  * A single byte gives backward compatibility with ASCII

  UTF-8 is backwards compatible with characters whose codepoint is less than 0b10000000 (128)
  In other words: characters below 128 are encoded
  in UTF8 exactly like they were represented in the pre-Unicode era, one character == one byte

  We'll write a converter: UTF-8 encoded binary to a list of codepoints

  """

  test "a UTF-8 encoded string to a list of codepoints, reimplement ?x " do
    "hello" |> Utf8DecoderV1.utf8_to_codepoints() |> IO.inspect(charlists: false)
  end

  test "with a 2-byte character" do
    "heλλo" |> Utf8DecoderV2.utf8_to_codepoints() |> IO.inspect(charlists: false)
    ?λ |> IO.inspect()
  end

  test "with a 3-byte character" do
    "heλლo" |> Utf8DecoderV3.utf8_to_codepoints() |> IO.inspect(charlists: false)
    ?ლ |> IO.inspect()
  end

  test "with a 4-byte character" do
    "heλლo 💩" |> Utf8DecoderV4.utf8_to_codepoints() |> IO.inspect(charlists: false)
    ?💩 |> IO.inspect()
  end

  test "failing with if input is not valid UTF-8" do
    <<0b10111111, 0b10111111, 0b10111111>>
    |> Utf8DecoderV4.utf8_to_codepoints()
    |> IO.inspect(charlists: false)
  end

  test "adding validation" do
    <<0b10111111, 0b10111111, 0b10111111>>
    |> Utf8DecoderV5.utf8_to_codepoints()
    |> IO.inspect(charlists: false)
  end
end
