class CreateCamps < ActiveRecord::Migration
  def change
    create_table :camps do |t|
      t.string :name
      t.string :start_date
      t.string :end_date
      t.string :location

      t.timestamps null: false
    end
  end
end
