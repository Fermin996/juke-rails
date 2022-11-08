class HomeController < ApplicationController
  def index
    url="https://resque.stg.hakuapp.com/albums.json"
    response = RestClient.get(url)
    allAlbums = JSON.parse(response)

    styles_cont = Styles.all   
    song_index = nil
    songs = nil
    for album in all_albums

      # getting albums style and matching it by corresponding id
      album_style = styles_cont.detect {|style| style.styles_id === album['id']}
      if album_style.style === "album-div album3"

        # if album style is album3 it is the album whose songs are called
        song_index = album_style.styles_id
        response = RestClient.get("https://resque.stg.hakuapp.com/songs.json?album_id=#{album['id']}")
        songs = JSON.parse(response)

        @album_favorites = Favorites.find_by(album_id: album['id'])
        @album_id = album['id']
      end  
      album['style'] = album_style.style
      
    end
    
    for song in songs
      foundFavorite = Favorites.find_by(album_id: song_index, song_name: song["song_name"])

      if foundFavorite === nil
        song['style'] = "star-color"
      else
        song['style'] = "selected-star-color"  
      end
    end    
    @albms = all_albums
    @album_songs = songs
  end

end
