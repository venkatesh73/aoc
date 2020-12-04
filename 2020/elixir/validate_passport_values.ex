defmodule ValidatePassportValues do
  @required_fields ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def parse_inputs() do
    "validate_password_values.txt"
    |> File.read!()
    |> String.split("\n\n", trim: true)
    |> Enum.map(
      &get_formatted_map(&1)
    )
  end

  def get_formatted_map(password) do
    Enum.reduce(
      @required_fields,
      %{},
      fn field, result ->
        regex = ~r/#{field}:(?<#{field}>[(\w | #\w)]*)/
        pattern = Regex.named_captures(regex, password)
        if pattern do
          [formatted_values | _] = String.split(pattern[field], " ", trim: true)
          pattern = Map.put(pattern, field, formatted_values)
          Map.merge(result, pattern)
        else
          result
        end
      end
    )
  end

  def validate_passport() do
    inputs = parse_inputs()
    Enum.reduce(
      inputs,
      0,
      fn passport, count ->
        with  {:valid_passport} <- is_valid_passport(passport),
              {:valid_birth_year} <- is_valid_birth_year(passport),
              {:valid_issue_year} <- is_valid_issue_year(passport),
              {:valid_expr_year} <- is_valid_expr_year(passport),
              {:valid_height} <- is_valid_height(passport),
              {:valid_hair_color} <- is_valid_hair_color(passport),
              {:valid_eye_color} <- is_valid_eye_color(passport),
              {:valid_passport_id} <- is_valid_pid(passport)
        do
          count + 1
        else
          _ ->
            count
        end
      end
    )
  end

  def is_valid_passport(passport) do
    passport_keys =
      passport
      |> Map.keys()
      |> Enum.sort()
      |> Enum.join()

    required_fields =
      @required_fields
      |> Enum.sort()
      |> Enum.join()

    if required_fields == passport_keys do
      {:valid_passport}
    else
      {:invalid_passport}
    end

  end

  def is_valid_birth_year(%{"byr" => byr}) do
    birth_year = String.to_integer(byr)
    if birth_year >= 1920 and birth_year <= 2002 do
      {:valid_birth_year}
    else
      {:invaild_birth_year}
    end
  end

  def is_valid_issue_year(%{"iyr" => iyr}) do
    issue_year = String.to_integer(iyr)
    if issue_year >= 2010 and issue_year <= 2020 do
      {:valid_issue_year}
    else
      {:invalid_issue_year}
    end
  end

  def is_valid_expr_year(%{"eyr" => eyr}) do
    expr_year = String.to_integer(eyr)
    if expr_year >= 2020 and expr_year <= 2030 do
      {:valid_expr_year}
    else
      {:invalid_expr_year}
    end
  end

  def is_valid_height(%{"hgt" => hgt}) do
    height_type = String.replace(hgt, ~r/\d/, "")
    height_value = String.to_integer(String.replace(hgt, ~r/[a-zA-Z]/, ""))
    case height_type do
      "cm" ->
        if height_value >=150 and height_value <= 193 do
          {:valid_height}
        else
          {:invalid_height}
        end
      "in" ->
        if height_value >=59 and height_value <= 76 do
          {:valid_height}
        else
          {:invalid_height}
        end
      _ ->
        {:invalid_height}
    end
  end

  def is_valid_hair_color(%{"hcl" => hcl}) do
    if String.match?(hcl, ~r/^#[0-9a-fA-F]{6}$/) do
      {:valid_hair_color}
    else
      {:invalid_hair_color}
    end
  end

  def is_valid_eye_color(%{"ecl" => ecl}) do
    valid_eye_colors = "amb blu brn gry grn hzl oth"
    if String.contains?(valid_eye_colors, ecl) do
      {:valid_eye_color}
    else
      {:invalid_eye_color}
    end
  end

  def is_valid_pid(%{"pid" => pid}) do
    if String.match?(pid, ~r/^[0-9]{9}$/) do
      {:valid_passport_id}
    else
      {:invalid_passport_id}
    end
  end
end
