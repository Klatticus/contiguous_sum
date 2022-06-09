defmodule ContigSum do
  @moduledoc """
  Documentation for `ContigSum`.
  """

  @doc """
  `check_list_for_sum/2` takes a list of numbers and a target sum.
  It then looks to see if a contiguous group of
  numbers in the list add up to the target sum.

  Returns :found if group is found, :not_found otherwise

  ## Examples

      iex> ContigSum.check_list_for_sum([1,2,3,4,5], 9)
      :found

      iex> ContigSum.check_list_for_sum([1,2,3,4,5], 13)
      :not_found
  """
  def check_list_for_sum(list, target) do
    list
    |> summation_tasks(target)
    |> Enum.map(&Task.await/1)
    |> Enum.find(:not_found, &(&1 == :found))
  end

  # summation_tasks/3 is an internal function that takes a list and a target sum,
  # creates a Task for the processing of the list using target_sum/3, and adds the
  # task to the accumulator collection. The function recurses, removing an element
  # from the list each time, until the complete list has been processed.
  defp summation_tasks(list, target, collection \\ [])

  defp summation_tasks([], _, collection), do: collection

  defp summation_tasks(list = [_head | tail], target, collection) do
    task = Task.async(__MODULE__, :target_sum, [list, target])
    summation_tasks(tail, target, [task | collection])
  end

  # target_sum/3 is another internal use function, though it is not private due to
  # the setup in summation_tasks/3. target_sum/3 takes the list and the target value,
  # and adds the numbers until the target is reached or exceeded, or the list is
  # emptied.
  def target_sum(list, target, accumulator \\ 0)

  def target_sum(_list, target, accumulator) when accumulator == target, do: :found
  def target_sum([], _target, _accumulator), do: :not_found
  def target_sum(_list, target, accumulator) when accumulator > target, do: :not_found

  def target_sum([head | tail], target, accumulator) do
    target_sum(tail, target, accumulator + head)
  end
end
