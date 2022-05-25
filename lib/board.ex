defmodule Board do
  def init(w, h) do
    Enum.map(1..h, fn i -> build_row([], w) end)
  end

  def build_row(board_in_progress, w) do
    Enum.map(1..w, fn x -> nil end)
  end

  def width(board) do
    List.first(board)
    |> length()
  end

  def height(board) do
    length(board)
  end

  def place_ship(ship_length, cell, oriantation, board) do
    coordinate = decode_coordinates(cell)

    list = get_cells_ship_will_cover(ship_length, coordinate, oriantation)
    all_coordinates_within_bounds?(list, board)

    # TODO: More here
  end

  def all_coordinates_within_bounds?(coordinates, board) do
  # > [%{x: 1, y: 3}, %{x: 2, y: 3}]

    Enum.all?(coordinates, fn coord ->
      coordinate_within_bounds?(coord, board)
    end)
    # true
  end

  def coordinate_within_bounds?(coordinate, board) do
    # %{x:, y:}
    coordinate.x <= width(board)
    coordinate.y <= height(board)
    # true
  end

  def get_cells_ship_will_cover(length, coordinate, oriantation) do
    # > (4, %{x: 1, y: 3}, "h")

    Enum.map(0..length - 1, fn index ->
      case oriantation do
        "h" -> %{x: coordinate.x + index, y: coordinate.y}
        "v" -> %{x: coordinate.x, y: coordinate.y  + index}
      end
    end)
    # > [
      #   %{x: 1, y: 3}, %{x: 2, y: 3}, %{x: 3, y: 3}, %{x: 4, y: 3}
    # ]
  end

  def decode_coordinates(coordinate) do
    # > "B1"
    [unconverted_x_coord | [y_coord]] = String.split(coordinate, "", trim: true)

    <<partly_converted_x_coord::utf8>> = unconverted_x_coord
    x_coord = partly_converted_x_coord - 64

    %{x: x_coord, y: String.to_integer(y_coord)}
    # > %{x: 2, y: 1}
  end
end
