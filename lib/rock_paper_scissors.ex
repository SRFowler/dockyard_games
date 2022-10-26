defmodule Games.RockPaperScissors do
  @moduledoc """
  The classic Rock, Paper, Scissors game between a human player
  and an 'ai' that randomly picks an option.
  """

  @doc """
  Checks if player1 beats player2 and returns a boolean.
  ## Examples
      iex> Games.RockPaperScissors.beats?("rock", "scissors")
      true
      iex> Games.RockPaperScissors.beats?("rock", "paper")
      false
  """
  @spec beats?(String.t(), String.t()) :: boolean()
  def beats?(player1, player2),
    do:
      {player1, player2} in [
        {"rock", "scissors"},
        {"paper", "rock"},
        {"scissors", "paper"}
      ]

  @doc """
  Start the game
  """
  @spec start :: String.t()
  def start do
    player_choice = IO.gets("rock/paper/scissors: ") |> String.trim()
    ai_choice = Enum.random(["rock", "paper", "scissors"])

    cond do
      beats?(player_choice, ai_choice) -> "You win! #{player_choice} beats #{ai_choice}"
      beats?(ai_choice, player_choice) -> "You lose! #{ai_choice} beats #{player_choice}"
      true -> "It's a tie!"
    end
  end
end
