defmodule OpponentTest do
  use ExUnit.Case
  doctest Opponent

  test "placing ships" do
    board = Board.init(4,4)
    result = Opponent.place_ships(board, [2, 3])

    assert Board.empty?(result) == false
  end
end
