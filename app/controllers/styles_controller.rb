class StylesController < ApplicationController

    def index
        stylesCont = Styles.all

        direction = params[:direction]

        isLeft = direction === "left"
        limit = nil
        start = nil
        shift_number = nil

        found = Styles.where(styles_id: 1)

        if isLeft
            limit = 'album5'
            start = 'album1'
            shift_number = 1
        else  
            limit = 'album1'
            start = 'album5'
            shift_number = -1
        end            

        stylesCont.each do |style|
            new_style = nil

            # shift all styles left or right based on direction params
            if style.style === "album-div #{limit}"
                new_style = "album-div #{start}" 
                Styles.where(styles_id: style.styles_id).update(style: new_style)
            else
                new_style = 'album-div album' + "#{(Integer(style.style[-1])+shift_number)}"
                Styles.where(styles_id: style.styles_id).update(style: new_style)
            end

            if style.styles_id === 1
                @style1 = new_style
            elsif style.styles_id === 2
                @style2 = new_style
            elsif style.styles_id === 3
                @style3 = new_style
            elsif style.styles_id === 4
                @style4 = new_style
            elsif style.styles_id === 5
                @style5 = new_style
            end

            if new_style === 'album-div album3'
                # album3 is the selected album. The corresponding id is used to get songs for that album.
                @album_id = style.styles_id
                response = RestClient.get("https://resque.stg.hakuapp.com/songs.json?album_id=#{style.styles_id}")
                songs = JSON.parse(response)

                for song in songs
                    foundFavorite = Favorites.find_by(album_id: style.styles_id, song_name: song["song_name"])
                
                    if foundFavorite === nil
                        song['style'] = 'star-color'
                    else
                        song['style'] = 'selected-star-color'  
                    end
                end   

                @album_songs = songs

            end 
        end     

    end    

    def edit
    end    
end    