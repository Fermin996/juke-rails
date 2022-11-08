class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :artist_name
      t.string :cover_photo_url
      t.string :string

      t.timestamps
    end
  end
end
