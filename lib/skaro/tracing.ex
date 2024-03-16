defmodule Skaro.Tracing do
  @moduledoc """
  Set of functions to trace and send events to the tracing system.
  Uses :telemetry internally, sends events to Datadog in production.
  See SkaroWeb.Telemtry for metrics handling.
  """
  def trace(event, tags, fun) do
    :telemetry.span(
      event,
      tags,
      fn ->
        result = fun.()

        {result, tags}
      end
    )
  end

  def send_count(event, count \\ 1, tags) do
    :telemetry.execute(event, %{count: count}, tags)
  end
end
