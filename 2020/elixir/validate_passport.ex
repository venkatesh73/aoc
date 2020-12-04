defmodule ValidatePassport do
  @required_fields "byrecleyrhclhgtiyrpid"

  def parse_inputs() do
    "passport.txt"
    |> File.read!()
    |> String.split("\n\n",trim: true)
  end

  def validate() do
    inputs = parse_inputs()
    Enum.reduce(
      inputs,
      0,
      fn passport, count ->
        case is_valid(passport) do
          true ->
            count + 1
          false ->
            count
        end
      end
    )
  end

  def is_valid(passport) do
    @required_fields == format(passport)
  end

  defp format(input) do
    Regex.scan(~r/\w{1,3}:/, input)
    |> Enum.join()
    |> String.split(":", trim: true)
    |> Enum.sort()
    |> Enum.join()
    |> String.replace("cid", "")
  end
end

ValidatePassport.validate() |> IO.inspect()
