desc "Insert initial semester into databse"

task :bootstrap_semester => [:environment] do
  Semester.create(year: 2014, parity: 1, open: false)
end