defmodule Utf8Test do
  use ExUnit.Case, async: true

  test "a string is a binary" do
    byte_size("λ") |> IO.puts()

    <<first_byte::size(8), second_byte::size(8)>> = "λ"
    IO.puts(first_byte)
    IO.puts(second_byte)
  end

  test "codepoints == utf8 bytes when the codepoint is lower than 128 / 0b10000000" do
    IO.inspect(?L)

    IO.inspect("L", base: :binary)

    <<num::integer-size(8)>> = "L"

    IO.inspect(num)

    assert num == ?L
  end

  test "codepoints != utf8 bytes when the codepoint is higher than 127 / 0b01111111" do
    IO.inspect(?λ)

    IO.inspect("λ", base: :binary)

    <<num::integer-size(16)>> = "λ"

    IO.inspect(num)

    assert num != ?λ, "What's going on here?"
  end
end
