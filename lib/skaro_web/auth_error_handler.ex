defmodule SkaroWeb.AuthErrorHandler do
  @moduledoc """
  Handles Guardian errors
  """
  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(type)})
    send_resp(conn, 401, body)
  end
end
