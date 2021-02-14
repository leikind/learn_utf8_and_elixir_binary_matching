defmodule Utf8EncodeUtf8Test do
  use ExUnit.Case, async: true

  test "encode ASCII codepoints" do
    [104, 101, 108, 108, 111] |> Utf8EncoderV1.codepoints_to_utf8() |> IO.inspect()
  end

  # https://en.wikipedia.org/wiki/List_of_Unicode_characters#Greek_and_Coptic
  test "with a codepoint which will take 2 bytes when encoded" do
    # 955 is λ
    [104, 101, 955, 955, 111] |> Utf8EncoderV2.codepoints_to_utf8() |> IO.inspect()
  end

  test "with a codepoint which will take 3 bytes when encoded" do
    # 4314 is ლ
    [104, 101, 4314, 32, 955, 111] |> Utf8EncoderV3.codepoints_to_utf8() |> IO.inspect()
  end

  test "with a codepoint which will take 4 bytes when encoded" do
    # 128_169 is 💩
    [104, 101, 108, 108, 111, 32, 128_169] |> Utf8EncoderV4.codepoints_to_utf8() |> IO.inspect()
  end

  test "pick any codepoint and print it" do
    # https://en.wikipedia.org/wiki/Devanagari_(Unicode_block)
    # 2384 is AUM in Devanagari: ॐ
    [32, 2384, 32] |> Utf8EncoderV4.codepoints_to_utf8() |> IO.inspect()
    # 24859 is Chinese for Love
    [32, 24859, 32] |> Utf8EncoderV4.codepoints_to_utf8() |> IO.inspect()
  end
end
