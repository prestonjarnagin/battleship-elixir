defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "checks for collisions" do
    board = Board.init(2, 2)
    board = Board.update_cell(%{x: 1, y: 1}, board)

    ship = [
      %{x: 1, y: 1},
      %{x: 1, y: 2}
    ]

    assert Board.has_collision?(ship, board) == true
  end

  test "checks for no collisions" do
    board = Board.init(2, 2)
    board = Board.update_cell(%{x: 1, y: 1}, board)

    ship = [
      %{x: 2, y: 1},
      %{x: 2, y: 2}
    ]

    assert Board.has_collision?(ship, board) == false
  end
end
