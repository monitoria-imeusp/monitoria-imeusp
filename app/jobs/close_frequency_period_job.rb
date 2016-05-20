class CloseFrequencyPeriodJob

  @period

  def initialize period
    @period = period
  end

  def perform
    Semester.close_frequency_period @period
  end

  def max_run_time
    300 #seconds
  end

  def destroy_failed_jobs?
      true
  end

  def queue_name
    #FIXME: maybe change this?
    'pending_frequencies_queue'
  end

end
