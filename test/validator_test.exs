defmodule ValidatorTest do
  use ExUnit.Case
  doctest Validator

  test "validates cordinate input" do
    assert Validator.valid_coordinate?("a1") == true
    assert Validator.valid_coordinate?("a2") == true
    assert Validator.valid_coordinate?("a3") == true
    assert Validator.valid_coordinate?("a4") == true
    assert Validator.valid_coordinate?("b1") == true
    assert Validator.valid_coordinate?("b2") == true
    assert Validator.valid_coordinate?("b3") == true
    assert Validator.valid_coordinate?("b4") == true
    assert Validator.valid_coordinate?("c1") == true
    assert Validator.valid_coordinate?("c2") == true
    assert Validator.valid_coordinate?("c3") == true
    assert Validator.valid_coordinate?("c4") == true
    assert Validator.valid_coordinate?("d1") == true
    assert Validator.valid_coordinate?("d2") == true
    assert Validator.valid_coordinate?("d3") == true
    assert Validator.valid_coordinate?("d4") == true
  end

  test "refutes cordinate input" do
    assert Validator.valid_coordinate?("a11")   == false
    assert Validator.valid_coordinate?("bb1")   == false
    assert Validator.valid_coordinate?("hello") == false
  end
end
