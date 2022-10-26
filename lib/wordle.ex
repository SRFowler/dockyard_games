defmodule Games.Wordle do


  def feedback(answer, guess) when answer == guess do
    len = String.length(answer)
    for _ <- 1..len, do: :green
  end

  def feedback(answer, guess) do
    [answer, guess]
    |> Enum.map(fn str -> String.downcase(str) |> String.split("", trim: true) end)
    |> check_green()
    |> check_yellow_grey()
  end

 def check_green([answer, guess]) do
   {remaining_letters, guess} =
    [answer, guess]
    |> List.zip()
    |> Enum.map(fn {answer, guess} -> if answer == guess, do: {nil, :green}, else: {answer, guess} end)
    |> Enum.unzip()

    [Enum.filter(remaining_letters, fn elem -> is_binary(elem) end), guess]
 end

 def check_yellow_grey([answer, guess]) do
   {_, guess} =
    Enum.reduce(guess, {answer, []}, fn elem, {answer, result} ->
      cond do
        elem == :green -> {answer, [:green | result]}
        elem in answer -> {answer -- [elem], [:yellow | result]}
        true -> {answer, [:grey | result]}
      end
    end)

    Enum.reverse(guess)
 end
end
