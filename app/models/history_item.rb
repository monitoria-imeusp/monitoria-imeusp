class HistoryItem

	attr_accessor :course_name, :grade, :status, :year_semester, :year, :semester

	def initialize(course_code, grade, status, year_semester)
		@course_name = full_course_name(course_code)
		@grade = grade
		@status = status
		@year_semester = year_semester
		@year = year_semester[0..3]
		@semester = year_semester[4]
	end

	def <=>(other)
		self.year_semester <=> other.year_semester
	end

	def full_status
		status_hash[status]
	end

	private

		def status_hash
			{"DI" => "Dispensado", "T " => "Trancado", "MA" => "Matriculado", "P " => "Pendente", "I " => "Inscrito",
				"IR" => "Inscrição reservada", "IT" => "Inscrição em turma lotada", "IP" => "Inscrição em optativa preterida",
				"IL" => "Inscrição em lista de espera", "A " => "Aprovado", "RN" => "Reprovado por nota",
				"AE" => "Aproveitamento de estudo", "RA" => "Reprovado por nota e frequência", "RF" => "Reprovado por frequência",
				"DS" => "Dispensado por prova de suficiência"}
		end

		def full_course_name (course_code)
			course = Course.find_by(course_code: course_code)
			if course.nil?
				course_code
			else
				course_code + " - " + course.name
			end
		end

end
