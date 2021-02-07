defmodule UTF8DecoderValidationTest do
  use ExUnit.Case, async: true

  @moduledoc """

  0xxxxxxx                                <== a single byte
  110xxxxx 10xxxxxx                       <== a leading byte + 1 continuation byte
  1110xxxx 10xxxxxx 10xxxxxx              <== a leading byte + 2 continuation byte
  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx     <== a leading byte + 3 continuation byte

  * A leading byte defines how many continuation bytes follow
  * It is impossible to confuse a leading byte with a continuation byte
  * It is impossible to confuse a leading byte with a single byte
  * We can define border between characters easily
  * A single byte gives backward compatibility with ASCII

  We'll write a converter: UTF-8 encoded binary to a list of codepoints

  """

  test "a UTF-8 encoded string to a list of codepoints, reimplement ?x " do
    "hello" |> UTF8Decoder.utf8_to_codepoints() |> IO.inspect(charlists: false)

    "heλλo" |> UTF8Decoder.utf8_to_codepoints() |> IO.inspect(charlists: false)
    # ?λ |> IO.inspect()

    "heλლo" |> UTF8Decoder.utf8_to_codepoints() |> IO.inspect(charlists: false)
    # ?ლ |> IO.inspect()

    "heλლo 💩" |> UTF8Decoder.utf8_to_codepoints() |> IO.inspect(charlists: false)
    # ?💩 |> IO.inspect()
  end

  test "adding validation" do
    <<0b10111111, 0b10111111, 0b10111111>>
    # |> UTF8Decoder.utf8_to_codepoints()
    |> UTF8DecoderValidation.utf8_to_codepoints()
    |> IO.inspect()
  end
end
