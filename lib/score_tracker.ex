defmodule Games.ScoreTracker do
  use GenServer

  @doc """
  Start the `ScoreTracker` process.

  ## Examples

    iex> {:ok, pid} = ScoreTracker.start_link([])
  """
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  @doc """
  Asynchronously increase the stored score by the specified amount.

  ## Examples

      iex> {:ok, pid} = ScoreTracker.start_link([])
      iex> ScoreTracker.score(pid, 10)
      :ok
  """
  def score(score_tracker_pid, amount) do
    GenServer.cast(score_tracker_pid, {:score, amount})
  end

  @doc """
  Synchronously return the current score state.

  ## Examples

      iex> {:ok, pid} = ScoreTracker.start_link([])
      iex> ScoreTracker.get_score(pid)
      0
  """
  def get_score(score_tracker_pid) do
    GenServer.call(score_tracker_pid, :get_score)
  end

  @impl true
  def init(_opts) do
    {:ok, 0}
  end

  @impl true
  def handle_cast({:score, amount}, state) do
    {:noreply, state + amount}
  end

  @impl true
  def handle_call(:get_score, _from, state) do
    {:reply, state, state}
  end
end
