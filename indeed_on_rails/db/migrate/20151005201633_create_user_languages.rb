class CreateUserLanguages < ActiveRecord::Migration
  def change
    create_table :user_languages do |t|
      t.belongs_to :user_id, index: true
      t.belongs_to :language_id, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_languages, :user_ids
    add_foreign_key :user_languages, :language_ids
  end
end
