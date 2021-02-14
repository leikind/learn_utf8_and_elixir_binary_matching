defmodule EnterUnicodeTest do
  use ExUnit.Case, async: true

  # https://en.wikipedia.org/wiki/List_of_Unicode_characters#Greek_and_Coptic
  test "Unicode codepoints" do
    ?L |> IO.puts()
    ?λ |> IO.puts()
    ?ლ |> IO.puts()
    ?💩 |> IO.puts()
  end

  # Unicode versus unicode encodings

  test "codepoint of L vs L encoded" do
    ?L |> IO.puts()

    <<"L"::utf8>> |> IO.inspect(binaries: :as_binaries)
    <<"L"::utf16>> |> IO.inspect(binaries: :as_binaries)
    <<"L"::utf32>> |> IO.inspect(binaries: :as_binaries)
  end

  test "codepoint of λ vs λ encoded" do
    ?λ |> IO.puts()

    <<"λ"::utf8>> |> IO.inspect(binaries: :as_binaries)
    <<"λ"::utf16>> |> IO.inspect(binaries: :as_binaries)
    <<"λ"::utf32>> |> IO.inspect(binaries: :as_binaries)
  end

  test "extract the codepoint of λ from UTF-16" do
    ?λ |> IO.puts()

    lambda_utf16 = <<"λ"::utf16>>

    lambda_utf16 |> IO.inspect()

    <<codepoint::integer()-size(16)>> = lambda_utf16

    codepoint |> IO.inspect()
  end

  test "codepoint of ლ vs ლ encoded" do
    ?ლ |> IO.puts()

    <<"ლ"::utf8>> |> IO.inspect(binaries: :as_binaries)
    <<"ლ"::utf16>> |> IO.inspect(binaries: :as_binaries)
    <<"ლ"::utf32>> |> IO.inspect(binaries: :as_binaries)
  end

  test "extract the codepoint of ლ from UTF-16" do
    <<codepoint::integer()-size(16)>> = <<"ლ"::utf16>>

    assert codepoint == ?ლ
  end

  test "codepoint of 💩 vs 💩 encoded" do
    ?💩 |> IO.puts()

    <<"💩"::utf8>> |> IO.inspect(binaries: :as_binaries)
    <<"💩"::utf16>> |> IO.inspect(binaries: :as_binaries)
    <<"💩"::utf32>> |> IO.inspect(binaries: :as_binaries)
  end

  test "extract the codepoint of 💩 from UTF-32" do
    <<codepoint::integer()-size(32)>> = <<"💩"::utf32>>

    assert codepoint == ?💩
  end

  test "extract the codepoint of 💩 from UTF-16" do
    # homework!
    # very easy after finishing this presentation and looking at this table: https://en.wikipedia.org/wiki/UTF-16#Examples
  end
end
