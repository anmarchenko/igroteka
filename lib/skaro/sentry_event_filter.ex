defmodule Skaro.SentryEventFilter do
  @moduledoc """
  Filters unwanted errors and prevents them from being sent to sentry.
  See config/prod.exs
  """
  @behaviour Sentry.EventFilter

  def exclude_exception?(%Elixir.Phoenix.Router.NoRouteError{}, :plug), do: true
  def exclude_exception?(%Elixir.Ecto.NoResultsError{}, _), do: true
  def exclude_exception?(_exception, _source), do: false
end
