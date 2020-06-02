defmodule TaskeritoWeb.Schema do
  use Absinthe.Schema

  query do

    @desc ""
    field :test, :string do
      resolve fn (_, _) -> {:ok, "yo"} end
    end

  end
end
