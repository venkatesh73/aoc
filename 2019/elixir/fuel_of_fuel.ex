defmodule FuelOfFuel do
  @moduledoc """
  The Tyranny of the Rocket Equation

  Find the sum of Module fule requirement.
  """

  @spec run() :: any()
  def run() do
    modules = 'fuel_of_fuel.txt'
    |> File.read!()
    |> String.split("\n", trim: true)

    :timer.tc(FuelOfFuel, :sum_of_modules_fuel, [modules, 0])
    :timer.tc(FuelOfFuel, :sum_of_modules_fuel, [modules]) |> IO.inspect()
  end

  @spec sum_of_modules_fuel(modules :: list(), result :: integer()) :: integer()
  def sum_of_modules_fuel([module | inputs], result) do
    mass = get_fuel_of_fuel(String.to_integer(module), 0)
    sum_of_modules_fuel(inputs, result + mass)
  end

  def sum_of_modules_fuel([], result), do: result

  def get_fuel_of_fuel(module, result) when module > 0 do
    module_mass = if div(module, 3) > 2, do: (div(module, 3) - 2), else: 0
    get_fuel_of_fuel(module_mass, result + module_mass)
  end

  def get_fuel_of_fuel(module, result) when module <= 0, do: result

  @spec sum_of_modules_fuel(modules :: list()) :: integer()
  def sum_of_modules_fuel(modules) do
    Enum.reduce(modules, 0, fn module, result ->
      mass = get_fuel_of_fuel(String.to_integer(module), 0)
      result + mass
    end)
  end
end
