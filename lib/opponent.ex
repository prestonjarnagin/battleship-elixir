defmodule Opponent do

  @spec place_ships(list(), list()) :: list()
  def place_ships(board, ship_lengths) do
    Enum.reduce(ship_lengths, board, fn ship_length, acc ->
      place_ship(ship_length, acc)
    end)
  end

  def place_ship(ship_length, board) do
    height = Board.height(board)
    width = Board.width(board)
    orientation = Enum.random(["h","v"])

    x = :rand.uniform(width)
    y = :rand.uniform(height)

    r = Board.place_ship(ship_length, %{x: x, y: y}, orientation, board)
    if r == :invalid_placement do
      place_ship(ship_length, board)
    else
      r
    end
  end
end
