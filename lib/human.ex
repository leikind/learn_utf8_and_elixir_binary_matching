defmodule Human do
  @moduledoc false

  @type t :: %__MODULE__{
          first_name: String.t(),
          last_name: String.t(),
          age: non_neg_integer(),
          gender: atom
        }

  defstruct [:first_name, :last_name, :age, :gender]

  def helen do
    %__MODULE__{first_name: "Helen", last_name: "Peterson", age: 32, gender: :female}
  end

  def peter do
    %__MODULE__{first_name: "Peter", last_name: "Johnson", age: 34, gender: :male}
  end
end
