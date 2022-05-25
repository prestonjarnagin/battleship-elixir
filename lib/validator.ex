defmodule Validator do
  def valid_coordinate?(coordinate) do
    valid_input?(coordinate)
  end

  defp valid_input?(coordinate) do
    if String.length(coordinate) == 2 do
      parts = String.split(coordinate, "", trim: true)

      letter = List.first(parts)
      number = List.last(parts)

      letter_valid = Enum.member?(["a","b","c","d"], letter)
      number_valid = Enum.member?(["1","2","3","4"], number)

      if letter_valid && number_valid, do: true, else: false
    else
      false
    end
  end
end
