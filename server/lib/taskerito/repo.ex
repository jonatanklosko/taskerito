defmodule Taskerito.Repo do
  use Ecto.Repo,
    otp_app: :taskerito,
    adapter: Ecto.Adapters.Postgres
end
