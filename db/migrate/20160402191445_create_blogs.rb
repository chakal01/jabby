class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :url
      t.text :content
      t.string :name
      t.belongs_to :camp, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
