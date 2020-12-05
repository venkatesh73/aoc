defmodule MissingSeat do
  import BoardingPass

  def find_missing_seat() do
    all_seats =
      BoardingPass.check_seat_ids()
      |> Enum.sort(:asc)

    from_seats = List.first(all_seats)
    last_seats = List.last(all_seats)

    Enum.sum(from_seats..last_seats) - Enum.sum(all_seats)
  end
end
