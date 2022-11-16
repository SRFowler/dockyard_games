defmodule Games.MultiplayerScoreTracker do
  @moduledoc """
  Documentation for `MultiplayerScoreTracker`
  """
  use GenServer

  @doc """
  Start the `MultyplayerScoreTracker` process.

  ## Examples

      iex> {:ok, pid} = MultiplayerScoreTracker.start_link([])
  """
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  @doc """
  Asynchronously add to the score of a named player. Creates the player if they do not already exist.

  ## Examples

      iex> {:ok, pid} = MultiplayerScoreTracker.start_link([])
      iex> MultiplayerScoreTracker.score(pid, :player1, 10)
      :ok
      iex> MultiplayerScoreTracker.score(pid, :player2, 10)
      :ok
      iex> MultiplayerScoreTracker.score(pid, :abc, 10)
      :ok
  """
  def score(multiplayer_score_tracker_pid, player_name, amount) do
    GenServer.cast(multiplayer_score_tracker_pid, {:score, player_name, amount})
  end

  @doc """
  Synchronously retrieve all of the player scores in a map.

  ## Examples

      Empty Scores.

      iex> {:ok, pid} = MultiplayerScoreTracker.start_link([])
      iex> MultiplayerScoreTracker.all_scores(pid)
      %{}

      Single Player Score.

      iex> {:ok, pid} = MultiplayerScoreTracker.start_link([])
      iex> MultiplayerScoreTracker.score(pid, :player1, 10)
      iex> MultiplayerScoreTracker.score(pid, :player1, 10)
      iex> MultiplayerScoreTracker.all_scores(pid)
      %{player1: 20}

      Multiple Player Scores.

      iex> {:ok, pid} = MultiplayerScoreTracker.start_link([])
      iex> MultiplayerScoreTracker.score(pid, :player1, 10)
      iex> MultiplayerScoreTracker.score(pid, :player2, 10)
      iex> MultiplayerScoreTracker.all_scores(pid)
      %{player1: 10, player2: 10}
  """
  def all_scores(multiplayer_score_tracker_pid) do
    GenServer.call(multiplayer_score_tracker_pid, :all_scores)
  end

  @doc """
  Synchronously retrieve a single player's score. Return `nil` if the player does not exist.

  ## Examples

    Player does not exist.

    iex> {:ok, pid} = MultiplayerScoreTracker.start_link([])
    iex> MultiplayerScoreTracker.get_score(pid, :player1)
    nil

    Player exists.

    iex> {:ok, pid} = MultiplayerScoreTracker.start_link([])
    iex> MultiplayerScoreTracker.score(pid, :abc, 10)
    iex> MultiplayerScoreTracker.get_score(pid, :abc)
    10
  """
  def get_score(multiplayer_score_tracker_pid, player_name) do
    GenServer.call(multiplayer_score_tracker_pid, {:get_score, player_name})
  end

  @impl true
  def init(_opts) do
    {:ok, 0}
  end

  @impl true
  def handle_cast({:score, player_name, amount}, state) do
    {:noreply, Map.update(state, player_name, amount, fn current -> current + amount end)}
  end

  @impl true
  def handle_call(:all_scores, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:get_score, player_name}, _from, state) do
    {:reply, state[player_name], state}
  end
end
