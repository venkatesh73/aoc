defmodule ValidatePasswordPosition do
  def parse_input() do
    "validate_password_position.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(
      fn unformatted ->
        [postions, character, password] = String.split(unformatted, " ", trim: true)
        [first, second] = String.split(postions, "-", trim: true)
        formatted_character = String.replace(character, ":", "")
        {{String.to_integer(first), String.to_integer(second)}, formatted_character, password}
      end
    )
    |> validate_password_position(0)
  end

  def validate_password_position([first | remaining], result) do
    {{postion_n, position_m}, character, password} = first

    n_character = String.at(password, postion_n - 1)
    m_character = String.at(password, position_m - 1)

    result =
      cond do
        n_character == character and m_character != character ->
          result + 1
        n_character != character and m_character == character ->
          result + 1
        true ->
          result
      end

    validate_password_position(remaining, result)
  end

  def validate_password_position([], result), do: result
end

ValidatePasswordPosition.parse_input() |> IO.inspect()
