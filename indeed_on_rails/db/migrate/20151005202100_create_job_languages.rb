class CreateJobLanguages < ActiveRecord::Migration
  def change
    create_table :job_languages do |t|
      t.belongs_to :language
      t.belongs_to :job

      t.timestamps null: false
    end
  end
end
