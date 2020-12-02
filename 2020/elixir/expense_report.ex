defmodule ExpenseReport do
  def run() do
    expenses =
      "expense_report.txt"
      |> File.read!()
      |> String.trim()
      |> String.split("\n", timr: true)

    calculate_report(expenses)
  end

  def calculate_report(expenses, result \\ 0)

  def calculate_report([number | expenses], result) do
    integer = String.to_integer(number)
    check_the_integer = 2020 - integer
    if Enum.find_value(expenses, fn second_operand ->
      second_operand == to_string(check_the_integer)
    end) do
      calculate_report([], check_the_integer * integer)
    else
      calculate_report(expenses, result)
    end
  end

  def calculate_report([], result), do: result
end

IO.inspect(:timer.tc(ExpenseReport, :run, []))
