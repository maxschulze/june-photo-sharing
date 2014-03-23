class AddAlbumIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :album_id, :integer

    add_index :photos, :album_id

    @album = Album.create!(name: 'Old Photos')
    Photo.update_all(album_id: @album.id)
  end
end