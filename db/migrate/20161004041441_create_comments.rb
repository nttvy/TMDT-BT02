class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :blog, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.string :content

      t.timestamps
    end
  end
end
