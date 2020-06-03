defmodule TaskeritoWeb.Schema do
  use Absinthe.Schema

  import_types AbsintheErrorPayload.ValidationMessageTypes
  import_types TaskeritoWeb.Schema.AccountTypes
  import_types TaskeritoWeb.Schema.ProjectTypes
  import_types TaskeritoWeb.Schema.TaskTypes
  import_types TaskeritoWeb.Schema.CommentTypes

  query do
    import_fields :user_queries
    import_fields :project_queries
    import_fields :task_queries
    import_fields :comment_queries
  end

  mutation do
    import_fields :user_mutations
    import_fields :project_mutations
    import_fields :task_mutations
    import_fields :comment_mutations
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
