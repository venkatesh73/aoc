defmodule ProgramAlarm do

  @spec run() :: integer()
  def run() do
    inputs =
      "program_alarm.txt"
      |> File.read!()
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.replace_at(1, 12)
      |> List.replace_at(2, 2)

    :timer.tc(ProgramAlarm, :int_code_comp, [inputs, 0, div(length(inputs), 4)])
  end

  @spec int_code_comp(inputs :: list(), iteration :: integer(), halt_limit :: integer()) :: integer()
  def int_code_comp(inputs, iteration, halt_limit) when iteration < halt_limit do
    index_from  = iteration * 4

    [op_code, first_pos, sec_pos, val_pos] = Enum.slice(inputs, index_from, 4)

    first_pos_val = Enum.at(inputs, first_pos)
    sec_pos_val = Enum.at(inputs, sec_pos)

    cond do
      op_code == 1 ->
        operated_val = first_pos_val + sec_pos_val
        updated_inputs = List.replace_at(inputs, val_pos, operated_val)
        int_code_comp(updated_inputs, iteration + 1, halt_limit)

      op_code == 2 ->
        operated_val = first_pos_val * sec_pos_val
        updated_inputs = List.replace_at(inputs, val_pos, operated_val)
        int_code_comp(updated_inputs, iteration + 1, halt_limit)

      true ->
        int_code_comp(inputs, halt_limit + 1, halt_limit)
    end
  end

  def int_code_comp(inputs, _iteration, _halt), do: Enum.at(inputs, 0)

end
