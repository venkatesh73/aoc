defmodule ExpenseReportAdv do
  def run() do
    input_puzzle =
      "expense_report_adv.txt"
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer(&1))

    calculate_expense(input_puzzle, 0)
  end

  def calculate_expense([number | expenses], result) do
    remaining =
      Enum.reduce(expenses, [], fn rest, result ->
        if (rest + number) < 2020, do: [rest | result], else: result
      end)

    computed =
      Enum.reduce_while(remaining, 0, fn operand, result ->
        next_half = 2020 - (number + operand)
        if Enum.find_value(expenses, fn second_operand ->
          second_operand == next_half
        end) do
          {:halt, number * operand * next_half}
        else
          {:cont, result}
        end
      end)

    if computed > 0 do
      calculate_expense([], computed)
    else
      calculate_expense(expenses, result)
    end

  end

  def calculate_expense([], result), do: result
end

ExpenseReportAdv.run() |> IO.inspect()
