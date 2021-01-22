defmodule ContigSumTest do
  use ExUnit.Case
  doctest ContigSum

  test "target_sum correctly handles match" do
    assert ContigSum.target_sum([], 3, 3) == :found
  end

  test "target_sum correctly handles empty list" do
    assert ContigSum.target_sum([], 3) == :not_found
  end

  test "target_sum correctly handles upper bound" do
    assert ContigSum.target_sum([1, 2], 3, 4) == :not_found
  end

  test "target_sum correctly sums lists" do
    assert ContigSum.target_sum([1, 2, 3, 4], 10) == :found
    assert ContigSum.target_sum([1, 2, 3, 4], 6) == :found

    assert ContigSum.target_sum([1, 2, 3, 4], 8) == :not_found
    assert ContigSum.target_sum([1, 2, 3, 4], 12) == :not_found
  end
end
