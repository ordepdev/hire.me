class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school
      t.string :course
      t.string :title
      t.integer :user_id
      t.date :graduation_date

      t.timestamps
    end
  end
end
