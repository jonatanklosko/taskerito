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

  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Taskerito.Repo, Dataloader.Ecto.new(Taskerito.Repo))

    Map.put(context, :loader, loader)
  end

  def plugins() do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end
end
