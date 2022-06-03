defmodule Board.Row do
  @spec build(list(), pos_integer()) :: list()
  def build(board_in_progress, w) do
    Enum.map(1..w, fn x -> nil end)
  end
end
