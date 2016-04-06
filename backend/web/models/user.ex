defmodule Firestorm.User do
  use Firestorm.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :username, :string

    timestamps
  end

  @required_fields ~w(email encrypted_password username)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
