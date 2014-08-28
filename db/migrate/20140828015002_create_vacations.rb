class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.integer :user_id
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.text :memo
      t.boolean :fixed

      t.timestamps
    end
  end
end
