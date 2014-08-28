class CreatePaidVacations < ActiveRecord::Migration
  def change
    create_table :paid_vacations do |t|
      t.integer :user_id
      t.integer :year
      t.float :hours
      t.float :carryover_hours

      t.timestamps
    end
  end
end
