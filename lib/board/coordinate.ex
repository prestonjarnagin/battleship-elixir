defmodule Board.Coordinate do
  @type coordinate :: %{x: pos_integer(), y: pos_integer()}

  def available?(coordinate, board) do
    Enum.at(board, coordinate.y - 1)
      |> Enum.at(coordinate.x - 1) == nil
  end

  @spec within_bounds?(coordinate(), list()) :: boolean()
  def within_bounds?(coordinate, board) do
    coordinate.x <= Board.width(board) and coordinate.y <= Board.height(board)
  end

  def update(coordinate, board) do
    old_row = Enum.at(board, coordinate.y - 1)
    new_row = List.replace_at(old_row, coordinate.x - 1, "O")
    List.replace_at(board, coordinate.y - 1, new_row)
  end
end
