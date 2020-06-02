defmodule TaskeritoWeb.Schema do
  use Absinthe.Schema

  import_types TaskeritoWeb.Schema.AccountTypes

  query do
    import_fields :user_queries
  end

  mutation do
    import_fields :user_mutations
  end
end
