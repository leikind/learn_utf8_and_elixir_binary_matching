defmodule Utf8EncodeUtf8Test do
  use ExUnit.Case, async: true

  test "encode ASCII codepoints" do
    [104, 101, 108, 108, 111] |> Utf8Encoder.codepoints_to_utf8() |> IO.inspect()
  end

  test "with a codepoint which will take 2 bytes when encoded" do
    [104, 101, 955, 955, 111] |> Utf8Encoder.codepoints_to_utf8() |> IO.inspect()
  end

  test "with a codepoint which will take 3 bytes when encoded" do
    [104, 101, 4314, 32, 955, 111] |> Utf8Encoder.codepoints_to_utf8() |> IO.inspect()
  end

  test "with a codepoint which will take 4 bytes when encoded" do
    [104, 101, 108, 108, 111, 32, 128_169] |> Utf8Encoder.codepoints_to_utf8() |> IO.inspect()
    # [2384] |> Utf8Encoder.codepoints_to_utf8() |> IO.inspect()
    # [24859] |> Utf8Encoder.codepoints_to_utf8() |> IO.inspect()
  end
end
