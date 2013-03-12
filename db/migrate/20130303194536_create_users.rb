class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :encrypted_password
      t.integer :ecampus_user_id
      t.integer :ecampus_student_id

      t.timestamps
    end
  end
end
