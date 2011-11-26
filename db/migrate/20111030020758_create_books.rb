class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :isbn
      t.string :cover_url
      t.references :type

      t.timestamps
    end
    add_index :books, :type_id
  end
end
