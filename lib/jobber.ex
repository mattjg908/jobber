defmodule Jobber do
  alias Jobber.{JobRunner, Job}

  @moduledoc """
  Documentation for `Jobber`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Jobber.hello()
      :world

  """
  def hello do
    :world
  end

  def start_job(args) do
    DynamicSupervisor.start_child(JobRunner, {Job, args})
  end
end
