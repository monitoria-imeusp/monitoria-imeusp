desc "Look for candidatures with ghost"

task :check_candidatures => [:environment] do
  Candidature.all.each do |candidature|
  	puts candidature.id if candidature.student.nil?
  end
end