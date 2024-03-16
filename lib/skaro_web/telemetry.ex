defmodule SkaroWeb.Telemetry do
  use Supervisor

  import Telemetry.Metrics

  require Logger

  alias Plug.Conn.Status, as: PlugStatus

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children =
      [
        # Telemetry poller will execute the given period measurements
        # every Nms. Learn more here: https://hexdocs.pm/telemetry_metrics
        {:telemetry_poller, measurements: periodic_measurements(), period: 30_000}
      ] ++ reporters()

    Supervisor.init(children, strategy: :one_for_one)
  end

  def metrics do
    [
      # Endpoint metrics
      distribution("phoenix.endpoint.stop.duration",
        tags: [:env, :service, :method, :http_code, :request_path],
        tag_values: &http_request_tags/1,
        unit: {:native, :millisecond},
        description: "The time spent processing a request"
      ),

      # Database Metrics
      distribution("skaro.repo.query.total_time",
        tags: [:env, :service],
        unit: {:native, :millisecond},
        description: "The sum of the other measurements"
      ),
      distribution("skaro.repo.query.decode_time",
        tags: [:env, :service],
        unit: {:native, :millisecond},
        description: "The time spent decoding the data received from the database"
      ),
      distribution("skaro.repo.query.query_time",
        tags: [:env, :service],
        unit: {:native, :millisecond},
        description: "The time spent executing the query"
      ),
      distribution("skaro.repo.query.queue_time",
        tags: [:env, :service],
        unit: {:native, :millisecond},
        description: "The time spent waiting for a database connection"
      ),
      distribution("skaro.repo.query.idle_time",
        tags: [:env, :service],
        unit: {:native, :millisecond},
        description:
          "The time the connection spent waiting before being checked out for the query"
      ),

      # VM Metrics
      summary("vm.memory.total",
        tags: [:env, :service],
        unit: {:byte, :kilobyte}
      ),
      summary("vm.total_run_queue_lengths.total", tags: [:env, :service]),
      summary("vm.total_run_queue_lengths.cpu", tags: [:env, :service]),
      summary("vm.total_run_queue_lengths.io", tags: [:env, :service]),

      # custom metrics

      # Games/IGDB
      # total number of calls to games module
      counter("skaro.games.call.count", tags: [:env, :service, :action]),
      # the number of calls to remote API
      counter("skaro.games.cache_miss.count", tags: [:env, :service, :action]),
      # number of times error occured when calling IGDB
      counter("skaro.igdb.error.count", tags: [:env, :service, :action]),
      # duration for IGDB API calls
      distribution("skaro.igdb.call.stop.duration",
        tags: [:env, :service, :action],
        unit: {:native, :millisecond}
      )
    ]
  end

  defp http_request_tags(%{conn: conn} = metadata) do
    id_regex = ~r/\/\d+\/?/

    request_path = String.replace(conn.request_path, id_regex, "/:id")
    response_code = PlugStatus.code(conn.status)

    metadata
    |> Map.put(:method, conn.method)
    |> Map.put(:http_code, response_code)
    |> Map.put(:request_path, request_path)
  end

  defp periodic_measurements do
    []
  end

  defp reporters do
    if Application.fetch_env!(:skaro, __MODULE__)[:report_metrics] do
      [
        {TelemetryMetricsStatsd,
         metrics: metrics(),
         global_tags: [env: "fly", service: "igroteka"],
         host: "ddagent.internal",
         inet_address_family: :inet6,
         formatter: :datadog}
      ]
    else
      []
    end
  end
end
