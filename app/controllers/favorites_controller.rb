class FavoritesController < ApplicationController

    def index
        album_id = params["album_id"]
        song_name = params["song_name"]
        @song_name = song_name

        foundFavorite = Favorites.find_by( album_id:album_id, song_name: song_name )
        
        if foundFavorite === nil
            newFavorite = Favorites.create(album_id: album_id, song_name: song_name)
            @fav_style = "fa-solid fa-star selected-star-color"
        else
            foundFavorite.destroy
            @fav_style = "fa-solid fa-star star-color"
        end     
    end    

end     