defmodule Games.GuessingGame do

  def start() do
    Enum.random(1..10)
    |> guess()
  end

  def guess(target) do
    data = IO.gets("Enter your guess: ")
    {guess, _} = Integer.parse(data)
    guess_check(guess, target)
  end

  def guess_check(guess, target) when guess == target do
    IO.puts("Correct!")
  end

  def guess_check(guess, target) when guess > target do
    IO.puts("Too High!")
    guess(target)
  end

  def guess_check(guess, target) when guess < target do
    IO.puts("Too Low!")
    guess(target)
  end
end
