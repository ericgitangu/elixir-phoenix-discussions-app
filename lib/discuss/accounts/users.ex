defmodule Discuss.Accounts.Users do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:email, :avatar_url, :name]}
  schema "users" do
    field :email, :string
    field :avatar_url, :string
    field(:name, :string)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:email, :avatar_url, :name])
    |> validate_required([:email, :name])
  end
end
