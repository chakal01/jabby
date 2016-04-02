class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file
      t.belongs_to :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
