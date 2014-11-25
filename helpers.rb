helpers do
  def show_artist_title(artist)
    if artist['artworks_count'].to_i > 0 || artist['biography']
      "<a href=\"/artista/#{artist['id']}\" title=\"#{artist['display_name']}\">
      #{artist['display_name']}</a>"
    else
      "#{artist['display_name']}"
    end
  end

  def show_artist_birth(artist)
    "Nacimiento: #{artist['birth']}" if artist['birth']
  end

  def show_artist_info(artist)
    artist_info = ''

    artist_info += "Nacimiento: #{artwork['year']}" if artist['year']

    if artist['biography']
      artist_info += "Biograf&iacute;a: #{artist['biography']}"
    end

    if artist['artworks']
      artist_info += "<h3>Obras</h3>\n\t<ul>"
      @artist['artworks'].each do |artwork|
        artist_info += "<li> \
                       <a href=\"/obras/#{artwork['id']}\" \
                       title=\"#{artwork['title']}\"> \
                       #{artwork['title']}<br/> \
                       <img src=\"#{artwork['image_thumbnail_url']}\"></a></li>"
      end
      artist_info += '</ul>'
    end

    artist_info
  end

end
