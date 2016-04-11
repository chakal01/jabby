class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.string :content
      t.boolean :active
      t.string :title
      t.string :date
      t.integer :ordre
      t.integer :views
      t.belongs_to :blog, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
