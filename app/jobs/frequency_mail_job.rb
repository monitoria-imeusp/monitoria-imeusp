class FrequencyMailJob 

	def perform
	    semester = Semester.current
	    requests = RequestForTeachingAssistant.where(semester: semester)
	    Professor.where(:professor_rank => [1, 2]).each do |super_professor|
		    pending_roles = []
	    	AssistantRole.where(request_for_teaching_assistant: requests).each do |assistant|
	    		if !AssistantFrequency.where(month: Time.now.month, assistant_role_id: assistant.id).any?
		    		if assistant.course.department == super_professor.department
		      			pending_roles.push(assistant)
		      		end
	      		end
	    	end	    	 
	    	if !pending_roles.empty?
	        	NotificationMailer.pending_frequencies_notification(pending_roles, super_professor).deliver   	    
	    	end
	    end	    
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