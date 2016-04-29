class FrequencyReminderJob 

	def perform
		AssistantFrequency.notify_frequency_reminder
	end

	def max_run_time
		300 #seconds
	end

	def destroy_failed_jobs?
  	false
	end

	def queue_name
		'pending_frequencies_queue'
	end

end