class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :job_title
      t.string :company
      t.text :description
      t.string :formatted_location
      t.string :date
      t.string :url

      t.timestamps null: false
    end
  end
end
