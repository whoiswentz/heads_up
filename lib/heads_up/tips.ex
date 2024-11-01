defmodule HeadsUp.Tips do
  def list_tips do
    [
      %{
        id: 1,
        text: "Slow is smooth, and smooth is fast! 🐢"
      },
      %{
        id: 2,
        text: "Working with a buddy is always a smart move. 👯‍♂️"
      },
      %{
        id: 3,
        text: "Take it easy and enjoy! 😊"
      }
    ]
  end

  def find_tip(id) when is_integer(id) do
    Enum.find(list_tips(), fn tip -> tip.id == id end)
  end

  def find_tip(id) do
    id
    |> String.to_integer()
    |> find_tip()
  end
end
