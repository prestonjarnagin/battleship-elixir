defmodule Board do

  @type coordinate :: %{x: pos_integer(), y: pos_integer()}

  @spec init(pos_integer(), pos_integer()) :: list()
  def init(w, h) do
    Enum.map(1..h, fn i -> build_row([], w) end)
  end

  @spec build_row(list(), pos_integer()) :: list()
  def build_row(board_in_progress, w) do
    Enum.map(1..w, fn x -> nil end)
  end

  @spec width(list()) :: pos_integer()
  def width(board) do
    List.first(board)
    |> length()
  end

  @spec height(list()) :: pos_integer()
  def height(board) do
    length(board)
  end

  def place_ship(ship_length, cell, oriantation, board) do
    coordinate = decode_coordinate(cell)

    list = get_cells_ship_will_cover(ship_length, coordinate, oriantation)
    all_coordinates_within_bounds?(list, board)

    # TODO: More here
  end

  @spec all_coordinates_within_bounds?(list(), list()) :: boolean()
  def all_coordinates_within_bounds?(coordinates, board) do
    Enum.all?(coordinates, fn coord ->
      coordinate_within_bounds?(coord, board)
    end)
  end

  @spec coordinate_within_bounds?(%{x: pos_integer(), y: pos_integer()}, list()) :: boolean()
  @spec coordinate_within_bounds?(coordinate(), list()) :: boolean()
  def coordinate_within_bounds?(coordinate, board) do
    coordinate.x <= width(board)
    coordinate.y <= height(board)
  end

  @spec get_cells_ship_will_cover(pos_integer(), %{x: pos_integer(), y: pos_integer()}, String.t()) :: list()
  @spec get_cells_ship_will_cover(pos_integer(), coordinate(), String.t()) :: list()
  def get_cells_ship_will_cover(length, coordinate, oriantation) do

    Enum.map(0..length - 1, fn index ->
      case oriantation do
        "h" -> %{x: coordinate.x + index, y: coordinate.y}
        "v" -> %{x: coordinate.x, y: coordinate.y  + index}
      end
    end)
  end

  @spec decode_coordinate(String.t()) :: %{x: pos_integer(), y: pos_integer()}
  def decode_coordinate(coordinate) do
    [unconverted_x_coord | [y_coord]] = String.split(coordinate, "", trim: true)

    <<partly_converted_x_coord::utf8>> = unconverted_x_coord
    x_coord = partly_converted_x_coord - 64

    %{x: x_coord, y: String.to_integer(y_coord)}
  end
end
