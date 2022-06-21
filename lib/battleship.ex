defmodule Battleship do
  @moduledoc """
  Documentation for `Battleship`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Battleship.hello()
      :world

  """
  def start do
    IO.puts "Battleship"

    # TODO: Rules

    board = Board.init(4, 4)
    ship_lengths = [2, 3]
    Presenter.puts(board)

    board = ship_placement_phase(board, ship_lengths)

    opponent_board = Board.init(4, 4)
    opponent_board = setup_opponent(opponent_board)

                require IEx; IEx.pry

  end

  def ship_placement_phase(board, ship_lengths) do
     Enum.reduce(ship_lengths, board, fn ship_length, acc ->
      # TODO: Loop until successful ship placement
      details = prompt_for_ship_details(ship_length)
      b = Board.place_ship(details.length, details.coordinate, details.orientation, acc)
      Presenter.puts(b)
      b
    end)
  end

  def setup_opponent(board, ship_lengths) do
    Opponent.place_ships(board, [2,3])
  end

  def prompt_for_ship_details(length) do
    IO.puts "Place Ship - #{length} Cells Long"
    IO.puts "Do you want to place it horizontally or vertically? (h/v)"

    orientation = gather_input()
                  |> String.downcase

    coordinate = prompt_for_placement(orientation)
    |> decode_coordinate

    %{orientation: orientation, length: length, coordinate: coordinate}
  end

  def gather_input do
    t = Task.async(fn -> IO.gets "---> " end)
    Task.await(t, :infinity)
    |> String.trim
    |> String.upcase
  end

  def prompt_for_placement("v") do
    IO.puts "Choose coordinates."
    IO.puts "Your choice will be the top-most part of the ship"
    input = gather_input()
    if Validator.valid_coordinate?(input) do
      input
    else
      false
    end
  end

  def prompt_for_placement("h") do
    IO.puts "Choose coordinates."
    IO.puts "Your choice will be the left-most part of the ship"
    input = gather_input()
    if Validator.valid_coordinate?(input) do
      input
    else
      false
    end
  end

  @spec decode_coordinate(String.t()) :: %{x: pos_integer(), y: pos_integer()}
  def decode_coordinate(coordinate) do
    [unconverted_y_coord | [x_coord]] = String.split(coordinate, "", trim: true)

    <<partly_converted_y_coord::utf8>> = unconverted_y_coord
    y_coord = partly_converted_y_coord - 64

    %{x: String.to_integer(x_coord), y: y_coord}
  end
end
