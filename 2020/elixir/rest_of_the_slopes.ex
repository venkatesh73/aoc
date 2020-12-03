defmodule RestOfTheSlopes do
  def parse_input() do
    "rest_of_the_slopes.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def find_steering_area(move_right, move_down) do
    inputs = parse_input()
    traverse(inputs, move_right, move_down, move_down, move_right, 0)
  end

  def traverse(inputs, move_right, move_down, down_idx, right_idx, trees) when down_idx < length(inputs) do
    geology = Enum.at(inputs, down_idx)
    geology_length = String.length(geology)
    duplicate_n_times = div(right_idx, geology_length)
    proper_geology = String.graphemes(String.duplicate(geology, duplicate_n_times + 1))

    trees =
      if Enum.at(proper_geology, right_idx) == "#" do
        trees + 1
      else
        trees
      end
    traverse(inputs, move_right, move_down, down_idx + move_down, right_idx + move_right, trees)
  end

  def traverse(_inputs, _move_right, _move_down, _down_idx, _right_idx, trees), do: trees

  def find_rest_of_slopes() do
    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.reduce(1, fn {right, down}, result ->
      result * find_steering_area(right, down)
    end)
  end
end

RestOfTheSlopes.find_rest_of_slopes() |> IO.inspect()
