defmodule Skaro.Query do
  @moduledoc """
    Common querying functions
  """
  import Ecto.Query

  @sort_fields_whitelist [
    "inserted_at",
    "finished_at",
    "game_release_date",
    "expectation_rating",
    "score",
    "game_name"
  ]

  def order_by_param(query, nil), do: query
  def order_by_param(query, "asc:" <> param), do: order_by_param(query, param, :asc)
  def order_by_param(query, "desc:" <> param), do: order_by_param(query, param, :desc)

  def order_by_param(query, "finished_at", direction) do
    direction_nulls_last = nulls_last(direction)
    from(p in query, order_by: [{^direction_nulls_last, :finished_at}])
  end

  def order_by_param(query, param, direction) when param in @sort_fields_whitelist do
    from(p in query, order_by: [{^direction, field(p, ^String.to_existing_atom(param))}])
  end

  def filter_if_present(query, _, nil), do: query

  def filter_if_present(query, param, filter_value) do
    from(p in query, where: field(p, ^param) == ^filter_value)
  end

  def search_if_term(query, _, nil), do: query

  def search_if_term(query, param, term) do
    search_term = "%#{term}%"
    from(p in query, where: ilike(field(p, ^param), ^search_term))
  end

  def preload_assoc(query, preloads) do
    from(p in query, preload: ^preloads)
  end

  defp nulls_last(:asc), do: :asc_nulls_last
  defp nulls_last(:desc), do: :desc_nulls_last
end
