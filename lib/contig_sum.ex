defmodule ContigSum do
  @moduledoc """
  Documentation for `ContigSum`.
  """

  @doc """
  check takes a list of numbers and a target sum.
  It then looks to see if a contiguous group of
  numbers in the list add up to the target sum.

  Returns :found if group is found, :not_found otherwise

  ## Examples

      iex> ContigSum.check([1,2,3,4,5], 9)
      :found

      iex> ContigSum.check([1,2,3,4,5], 13)
      :not_found
  """
  def check(list, target) do
    list
    |> summation_tasks(target)
    |> Enum.map(&Task.await/1)
    |> Enum.find(:not_found, &(&1 == :found))
  end

  defp summation_tasks(list, target, collection \\ [])

  defp summation_tasks([], _, collection), do: collection

  defp summation_tasks(list = [_head | tail], target, collection) do
    task = Task.async(__MODULE__, :target_sum, [list, target])
    summation_tasks(tail, target, [task | collection])
  end

  def target_sum(list, target, accumulator \\ 0)

  def target_sum(_list, target, accumulator) when accumulator == target, do: :found
  def target_sum([], _target, _accumulator), do: :not_found
  def target_sum(_list, target, accumulator) when accumulator > target, do: :not_found

  def target_sum([head | tail], target, accumulator) do
    target_sum(tail, target, accumulator + head)
  end
end
