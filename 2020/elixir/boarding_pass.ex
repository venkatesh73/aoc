defmodule BoardingPass do
  def parse_input() do
    "boarding_pass.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def check_seat_ids() do
    parse_input()
    |> Enum.map(&check_through_rows_and_columns(String.graphemes(&1)))
  end

  def check_through_rows_and_columns(row) do
    {f_and_b, r_and_l} = Enum.split(row, 7)
    get_through_rows(f_and_b, 0, 127, 128, []) * 8 + get_through_rows(r_and_l, 0, 7, 8, [])
  end

  def get_through_rows([ seat | reamining], from, to, total_rows, _result) do
    cond do
      seat == "F" or seat == "L" ->
        row = div(total_rows, 2)
        updated_result =
          {"F", %{
          "from_row" => from,
          "to_row" => to - row
        }}

        get_through_rows(reamining, from, to - row, row, updated_result)

      seat == "B" or seat == "R" ->
        row = div(total_rows, 2)

        updated_result ={"B", %{
          "from_row" => to - row + 1,
          "to_row" => to
        }}

        get_through_rows(reamining, to - row + 1, to, row, updated_result)

      true ->
        0
    end
  end

  def get_through_rows([], _from, _to, _total_rows, {"F", %{"from_row" => from_row, "to_row" => _to_row}}), do: from_row
  def get_through_rows([], _from, _to, _total_rows, {"B", %{"from_row" => _from_row, "to_row" => to_row}}), do: to_row
end

BoardingPass.check_seat_ids() |> Enum.sort(:desc) |> IO.inspect(limit: :infinity)
