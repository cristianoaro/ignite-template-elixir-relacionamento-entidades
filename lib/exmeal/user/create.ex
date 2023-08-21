defmodule Exmeal.Users.Create do
  alias Exmeal.Error
  alias Exmeal.Repo
  alias Exmeal.User

  def call(params) do
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, %User{} = user} <- Repo.insert(changeset) do
      {:ok, user}
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end
end
