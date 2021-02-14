defmodule PatternMatchingTest do
  use ExUnit.Case, async: true

  test "variable assignment?" do
    a = 42
    IO.puts(a)
  end

  test "no, pattern matching" do
    {:ok, a} = {:ok, 41}
    IO.puts(a)
  end

  # not array, FP, LinkedList
  # a list is recursive data structure
  # where each node contains a value and a reference to a list
  test "with lists" do
    [head | tail] = [42, 4, "💩", :foo]
    IO.inspect(head)
    IO.inspect(tail)
  end

  test "with types" do
    h = Human.helen() |> IO.inspect()

    %Human{age: age} = h

    IO.inspect(age)
  end

  test "deep structures" do
    some_structure = {:ok, [42, Human.helen(), 4, "💩", :foo]}

    {:ok, [_, %Human{age: age} | _]} = some_structure

    IO.inspect(age)
  end

  test "multiple assignments" do
    some_structure = {:ok, [42, Human.helen(), 4, "💩", :foo]}

    {:ok, [_, %Human{age: age} = helen | _]} = some_structure

    IO.inspect(helen)
    IO.inspect(age)
  end

  test "function calls are pattern matching" do
    may_merry? = fn
      %Human{}, %Human{} -> true
      _, _ -> false
    end

    may_merry?.(Human.helen(), Human.peter()) |> IO.inspect()
    may_merry?.(Dog.charlie(), Human.peter()) |> IO.inspect()
  end

  test "no underage marriages!" do
    may_merry? = fn
      %Human{age: age1}, %Human{age: age2} when age1 > 17 and age2 > 17 -> true
      _, _ -> false
    end

    may_merry?.(Human.helen(), Human.peter()) |> IO.inspect()
    may_merry?.(Dog.charlie(), Human.peter()) |> IO.inspect()
  end
end
