defmodule ValidatePassword do
  def parse() do
    "validate_password.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |>Enum.map(
      fn inputs ->
        [range, character, password] = String.split(inputs, " ", trim: true)
        [min, max] = String.split(range, "-", trim: true)
        validate_character = String.replace(character, ":", "")
        {{String.to_integer(min), String.to_integer(max)}, validate_character, password}
      end
    )
  end

  def validate() do
    inputs = parse()
    validate_password(inputs, 0)
  end

  def validate_password([ inputs | remaining], result) do
    {{min, max}, character, password} = inputs
    char_count =
      String.split(password, ~r/[^#{character}]/)
      |> Enum.join
      |> String.length

    result =
      if char_count >= min and char_count <= max do
        result + 1
      else
        result
      end

    validate_password(remaining, result)
  end

  def validate_password([], result), do: result
end

ValidatePassword.validate() |> IO.inspect()
