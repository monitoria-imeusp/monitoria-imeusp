class FrequencyMailJob 

	def perform
		AssistantFrequency.notify_frequency
	end

	def max_run_time
		300 #seconds
	end

	def destroy_failed_jobs?
  	false
	end

	def queue_name
		'notify_frequencies_queue'
	end

end