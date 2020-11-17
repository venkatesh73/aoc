defmodule RocketEquation do
  @moduledoc """
  The Tyranny of the Rocket Equation

  Find the sum of Module fule requirement.
  """

  @spec run() :: any()
  def run() do
    modules = 'rocket_equation.txt'
    |> File.read!()
    |> String.split("\n", trim: true)

    :timer.tc(RocketEquation, :sum_of_modules_fuel, [modules, 0]) |> IO.inspect()
    :timer.tc(RocketEquation, :sum_of_modules_fuel, [modules]) |> IO.inspect()
  end

  @spec sum_of_modules_fuel(modules :: list(), result :: integer()) :: integer()
  def sum_of_modules_fuel([module | inputs], result) do
    mass = String.to_integer(module)
    sum_of_modules_fuel(inputs, result + (div(mass, 3) - 2))
  end

  def sum_of_modules_fuel([], result), do: result

  @spec sum_of_modules_fuel(modules :: list()) :: integer()
  def sum_of_modules_fuel(modules) do
    Enum.reduce(modules, 0, fn module, result ->
      mass = String.to_integer(module)
      result + (div(mass, 3) - 2)
    end)
  end
end
