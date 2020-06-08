defmodule TaskeritoWeb.Schema do
  use Absinthe.Schema

  import_types AbsintheErrorPayload.ValidationMessageTypes
  import_types Absinthe.Type.Custom
  import_types TaskeritoWeb.Schema.UserTypes
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
    source = Dataloader.Ecto.new(Taskerito.Repo, query: &TaskeritoWeb.Schema.query/2)

    loader =
      Dataloader.new()
      |> Dataloader.add_source(Taskerito.Repo, source)

    Map.put(context, :loader, loader)
  end

  def plugins() do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  import Ecto.Query, warn: false

  def query(querable, %{order_by: order_by}) do
    querable |> order_by(^order_by)
  end

  def query(querable, _args) do
    querable
  end
end
