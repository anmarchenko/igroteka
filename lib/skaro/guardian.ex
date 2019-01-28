defmodule Skaro.Guardian do
  @moduledoc """
  Guardian module contains authentication rules.
  """
  use Guardian, otp_app: :skaro

  alias Skaro.Accounts.User
  alias Skaro.Repo

  def subject_for_token(%User{} = user, _claims), do: {:ok, user.id()}
  def subject_for_token(_, _), do: {:error, :unknown_resource_type}

  def resource_from_claims(%{"sub" => id}), do: {:ok, Repo.get(User, id)}
  def resource_from_claims(_claims), do: {:error, :wrong_claims}
end
