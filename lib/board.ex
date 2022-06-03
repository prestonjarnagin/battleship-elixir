defmodule Board do

  @type coordinate :: %{x: pos_integer(), y: pos_integer()}

  @spec init(pos_integer(), pos_integer()) :: list()
  def init(w, h) do
    Enum.map(1..h, fn i -> Board.Row.build([], w) end)
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

  def place_ship(ship_length, coordinate, orientation, board) do
    if valid_placement?(ship_length, coordinate, orientation, board) do
      populate_board(get_cells_ship_will_cover(ship_length, coordinate, orientation), board)
    else
      :invalid_placement
    end
  end

  def valid_placement?(ship_length, coordinate, orientation, board) do
    list = get_cells_ship_will_cover(ship_length, coordinate, orientation)
    all_coordinates_within_bounds?(list, board) and (not has_collision?(list, board))
  end

  def has_collision?(coordinates, board) do
    not Enum.all?(coordinates, fn coord ->
      coordinate_available?(coord, board)
    end)
  end

  def coordinate_available?(coordinate, board) do
    Enum.at(board, coordinate.y - 1)
      |> Enum.at(coordinate.x - 1) == nil
  end

  def populate_board(coordinates, board) do
    [head | tail] = coordinates

    if Enum.empty?(tail) do
      update_cell(head, board)
    else
      incoming = populate_board(tail, board)
      Enum.zip_with(incoming, update_cell(head, board),
        fn incoming_row, old_row ->
          Enum.zip_with(incoming_row, old_row, fn x, y -> x || y end)
      end)
    end
  end

  def update_cell(coordinate, board) do
    old_row = Enum.at(board, coordinate.y - 1)
    new_row = List.replace_at(old_row, coordinate.x - 1, "O")
    List.replace_at(board, coordinate.y - 1, new_row)
  end

  @spec all_coordinates_within_bounds?(list(), list()) :: boolean()
  def all_coordinates_within_bounds?(coordinates, board) do
    Enum.all?(coordinates, fn coord ->
      coordinate_within_bounds?(coord, board)
    end)
  end

  @spec coordinate_within_bounds?(coordinate(), list()) :: boolean()
  def coordinate_within_bounds?(coordinate, board) do
    coordinate.x <= width(board) and coordinate.y <= height(board)
  end

  @spec get_cells_ship_will_cover(pos_integer(), coordinate(), String.t()) :: list()
  def get_cells_ship_will_cover(length, coordinate, orientation) do

    Enum.map(0..length - 1, fn index ->
      case orientation do
        "v" -> %{x: coordinate.x, y: coordinate.y + index}
        "h" -> %{x: coordinate.x + index, y: coordinate.y }
      end
    end)
  end
end
