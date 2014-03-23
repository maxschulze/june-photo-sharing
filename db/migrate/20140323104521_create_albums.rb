class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :user_id
      t.boolean :public, default: false
      t.string :slug

      t.timestamps
    end

    add_index :albums, :user_id
    add_index :albums, :public
    add_index :albums, :slug, :unique: true
  end
end