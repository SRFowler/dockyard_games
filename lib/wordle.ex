defmodule Games.Wordle do


  def feedback(answer, guess) when answer == guess do
    [:green, :green, :green, :green, :green]
  end

  def feedback(answer, guess) do
    answer = String.split(answer, "", trim: true)
    guess = String.split(guess, "", trim: true)
    result = for letter <- guess do Enum.member?(answer, letter) end

    word_length = length(guess) - 1

    for x <- 0..word_length do
        cond do
          Enum.at(answer, x) != Enum.at(guess, x) and Enum.at(result, x) == true -> :yellow
          Enum.at(answer, x) == Enum.at(guess, x) -> :green
          Enum.at(result, x) == false -> :grey
        end
    end

  end

  def feedback2(answer, guess) do
    answer = String.split(answer, "", trim: true)
    guess = String.split(guess, "", trim: true)


  end

  @spec only_green([char()], [char()]) :: boolean()
  defp only_green(answer, guess) do
    Enum.zip(answer, guess)
  end
end
