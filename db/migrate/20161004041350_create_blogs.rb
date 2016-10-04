class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.references :user, foreign_key: true, index: true
      t.string :title
      t.text :content
      t.integer :nb_view

      t.timestamps
    end
  end
end
