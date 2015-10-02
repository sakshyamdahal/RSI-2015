class Job < ActiveRecord::Base
	
	filterrific(
    available_filters: [
      :company_name,
      :job_title,
      # :with_state_name,
      :location
    ]
  )

	# default for will_paginate
  	self.per_page = 10


	scope :search_query, lambda { |query|
    # Filters colleges whose name matches the query
	    return nil  if query.blank?
	    
	    # terms = query.downcase.split(/\s+/)
	    
	    # terms = terms.map { |e|
	    #   (e.gsub('*', '%') + '%').gsub(/%+/, '%')
	    # }

	    # configure number of OR conditions for provision
	    # of interpolation arguments. Adjust this if you
	    # change the number of OR conditions.
	   
	    where("name LIKE ?", query)
    	
  	}

  	

  	scope :company_name, lambda { |company_name|
    	# Filters colleges with any of the given country_name
    	
    	where(:company_name => [company_name])
  	}

  	scope :job_title, lambda { |jobtitle|
  		where(:jobtitle => [jobtitle])
    	
  	}

  	

  	scope :location, lambda { |location|
  		# Filters colleges with any of the given affiliation_id

    	 where(:location => [location])
  	}

  	# This method provides select options for the `sorted_by` filter select input.
  	# It is called in the controller as part of `initialize_filterrific`.
	def self.options_for_select(value)
		if value == "company_name"
  		order('LOWER(company_name)').map { |e| [e.company_name, e.company_name] }
  	elsif value == "job_title"
  		order('LOWER(jobtitle)').map { |e| [e.jobtitle, e.jobtitle] }
  	elsif value == "location"
  		order('LOWER(location)').map { |e| [e.location, e.location] }
  		end
	end

	def self.sorted_by filter
		order(filter)
	end
end
