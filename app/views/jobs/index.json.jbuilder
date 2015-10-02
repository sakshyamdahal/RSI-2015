json.array!(@jobs) do |job|
  json.extract! job, :id, :company_name, :jobtitle, :description, :location
  json.url job_url(job, format: :json)
end
