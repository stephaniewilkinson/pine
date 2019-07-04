defmodule Pine.Repo do
  use Ecto.Repo,
    otp_app: :pine,
    adapter: Ecto.Adapters.Postgres
end
