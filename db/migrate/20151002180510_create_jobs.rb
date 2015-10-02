class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :company_name
      t.string :jobtitle
      t.text :description
      t.string :location

      t.timestamps null: false
    end
  end
end
