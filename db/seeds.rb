# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

companies = ["Rural Sourcing", "Google", "IBM", "Apple"]
job_title = ["Accountant", "Programmer", "Software Engineer", "Voodoo Priest"]
descriptions = ["This account development manager sample job description can assist in your creating a job application that will attract job candidates who are qualified for the job. Feel free to revise this job description to meet your specific job duties and job requirements.",
	"Develops new business by analyzing account potential; initiating, developing, and closing sales; recommending new applications and sales strategies."]
locations = ["Augusta", "California", "Orangeburg"]


for number in 1..100
	job = Job.new
	job.company_name = companies[number%companies.length]
	job.jobtitle = job_title[number%job_title.length]
	job.description = descriptions[number%descriptions.length]
	job.location = locations[number%locations.length]
	job.save
end