desc "Look for candidatures with ghost"

task :check_candidatures => [:environment] do
  Candidature.all.each do |candidature|
  	print candidature if candidature.student.nil?
  end
end