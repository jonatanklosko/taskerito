defmodule TaskeritoWeb.Schema do
  use Absinthe.Schema

  import_types AbsintheErrorPayload.ValidationMessageTypes
  import_types TaskeritoWeb.Schema.AccountTypes
  import_types TaskeritoWeb.Schema.ProjectTypes

  query do
    import_fields :user_queries
    import_fields :project_queries
  end

  mutation do
    import_fields :user_mutations
    import_fields :project_mutations
  end
end
