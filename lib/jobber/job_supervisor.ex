defmodule Jobber.JobSupervisor do
  # ignore and do not try to restart sub-processes, even if sub-process exits
  # with an error
  use Supervisor, restart: :temporary

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args)
  end

  def init(args) do
    children = [
      {Jobber.Job, args}
    ]

    options = [
      strategy: :one_for_one,
      max_seconds: 30_000
    ]

    # delegates the rest of the work to Supervisor.init/2, which starts the
    # supervisor
    Supervisor.init(children, options)
  end
end
