defmodule Jobber do
  alias Jobber.{JobRunner, JobSupervisor}

  @moduledoc """
  Documentation for `Jobber`.
  """

  @doc """
  start_job/1

  ## Examples

      Jobber.start_job(work: good_job, type: "import")
      {:ok, #PID<0.167.0>}

  """
  def start_job(args) do
    DynamicSupervisor.start_child(JobRunner, {JobSupervisor, args})
  end

  def running_imports() do
    # wildcard that matches all entries in registry
    match_all = {:"$1", :"$2", :"$3"}
    # filters that results by 3rd element in tuple, which must equal "import"
    guards = [{:==, :"$3", "import"}]
    # transforms result by creating list of maps , assigns each element of tuple
    # to a key (makes result more readable"
    map_result = [%{id: :"$1", pid: :"$2", type: :"$3"}]
    Registry.select(Jobber.JobRegistry, [{match_all, guards, map_result}])
  end
end
