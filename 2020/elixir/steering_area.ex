defmodule SteeringArea do
  def parse_input() do
    "steering_area.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def find_steering_area() do
    inputs = parse_input()
    traverse(inputs, 1, 3, 0)
  end

  def traverse(inputs, down_idx, right_idx, trees) when down_idx < length(inputs) do
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
    traverse(inputs, down_idx + 1, right_idx + 3, trees)
  end

  def traverse(_inputs, _down_idx, _right_idx, trees), do: trees
end

SteeringArea.find_steering_area() |> IO.inspect()
