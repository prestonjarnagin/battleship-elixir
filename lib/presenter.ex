defmodule Presenter do
  def puts(board) do
    draw(board)
    |>IO.puts()
  end

  def draw(board) do
    w = Board.width(board)
    header = draw_header(w)

    rows = Enum.with_index(board, fn data, i -> draw_row(data, i) <> "\n" end)
    |> List.to_string

    header <> rows
  end

  def draw_header(w) do
    header = " "
    # TODO: Handle monospace errors after 10
    header = header <> (Enum.map(1..w, fn x -> " #{x} "end)
    |> List.to_string) <> "\n"
  end

  def draw_row(row, index) do
    drawn = Enum.map(row, fn
      element ->
        if element == nil, do: " . ", else: " #{element} "
    end)
    |> List.to_string

    # TODO: Handle letters past z
    <<(65 + index)>> <> drawn
  end
end
