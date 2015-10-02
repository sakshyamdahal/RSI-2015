class AddJobsUsersTable < ActiveRecord::Migration
  def change
  	 create_table :jobs_users do |t|
  	 t.integer :job_id
     t.integer :user_id
 	end
  end
end
