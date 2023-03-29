defmodule RandomPoints.Randomizer do
  use GenServer
  alias RandomPoints.Accounts

  @interval 10000

  def start_link(_) do
    state = [{:min_number, Enum.random(1..100)}, {:timestamp, nil}]
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def get_info(server_name, type) do
    GenServer.call(server_name, type)
  end

  @impl true
  def init(state) do
    schedule_work()

    {:ok, state}
  end

  @impl true
  def handle_call(:min_number, _from, state) do
    min_number = Keyword.get(state, :min_number)
    {:reply, min_number, state}
  end

  @impl true
  def handle_call(:users, _from, state) do
    users = Accounts.list_users(Keyword.get(state, :min_number))

    data = %{
      users: users,
      timestamp: Keyword.get(state, :timestamp),
      min_number: Keyword.get(state, :min_number)
    }

    new_state = Keyword.put(state, :timestamp, DateTime.utc_now())

    {:reply, data, new_state}
  end

  @impl true
  def handle_info(:update, state) do
    Accounts.update_all_users()
    new_state= Keyword.put(state, :min_number, Enum.random(1..100))

    schedule_work()
    {:noreply, new_state}
  end

  defp schedule_work do
    Process.send_after(self(), :update, @interval)
  end
end
