defmodule Dog do
  @moduledoc false

  @type t :: %__MODULE__{
          name: String.t(),
          age: non_neg_integer(),
          gender: atom
        }

  defstruct [:name, :age, :gender]

  def charlie do
    %__MODULE__{name: "charlie", gender: :male, age: 3}
  end
end
