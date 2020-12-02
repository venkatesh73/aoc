defmodule ExpenseReport do
  def parse(file) do
    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end

  def calculate_with_2_numbers() do
    input = parse("expense_report.txt")
    [{x, y}, _] = for x <- input, y <- input, x + y == 2020  do
     {x, y}
    end
    x * y
  end
end

IO.inspect(:timer.tc(ExpenseReport, :calculate_with_2_numbers, []))
