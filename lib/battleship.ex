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

    board = Board.init(4, 4)
    IO.puts(Renderer.draw(board))

    IO.puts "Place First Ship - 3 Cells Long"
    IO.puts "Do you want to place it horizontally or vertically? (h/v)"

    orientation = gather_input()
    cell = prompt_for_placement(orientation)

    Board.place_ship(3, cell, orientation, board)

    IO.puts(Renderer.draw(board))

    IO.puts "Place Second Ship - 2 Cells Long"
    IO.puts "Do you want to place it horizontally or vertically? (h/v)"

    # place_ship(2, cell, orientation)

    orientation = gather_input()
    cell = prompt_for_placement(orientation)
  end

  def gather_input do
    t = Task.async(fn -> IO.gets "---> " end)
    Task.await(t, :infinity)
    |> String.trim
    |> String.downcase
  end

  def prompt_for_placement("v") do
    IO.puts "Choose coordinates."
    IO.puts "Your choice will be the top-most part of the ship"
    input = gather_input()
    Validator.valid_coordinate?(input)
  end

  def prompt_for_placement("h") do
    IO.puts "Choose coordinates."
    IO.puts "Your choice will be the left-most part of the ship"
    input = gather_input()
    Validator.valid_coordinate?(input)
  end
end
