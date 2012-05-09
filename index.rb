require 'sinatra'
require 'haml'
require 'sass'
require './lib/artist_service.rb'
require './lib/artwork_service.rb'
require './lib/wikipedia_service.rb'


get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss :style
end

get '/' do
  haml :index
end

get '/acerca-de' do
  haml :about
end

get '/contacto' do
  haml :contact
end

get '/datos-abiertos' do
  haml :open_data
end

helpers do
  def show_artist_title(artist)
    if artist['artworks_count'].to_i > 0 || artist['biography']
      "<a href=\"/artista/#{artist['id']}\" title=\"artist['display_name']\">
      #{artist['display_name']}</a>"
    else
      "#{artist['display_name']}"
    end
  end

  def show_artist_birth(artist)
    if artist['birth']
      "Nacimiento: #{artist['birth']}"
    end
  end

  def show_artist_info(artist)
    artist_info = ''

    if artist['year']
      artist_info += "Nacimiento: #{artwork['year']}"
    end

    if artist['biography']
      artist_info += "Biograf&iacute;a: #{artist['biography']}"
    end

    if artist['artworks']
      artist_info += "<h3>Obras</h3>\n\t<ul>"
      @artist['artworks'].each do |artwork|
        artist_info += "<li><a href=\"/obras/#{artwork['id']}\" title=\"#{artwork['title']}\">
                        #{artwork['title']}<img src=\"#{artwork['image_thumbnail_url']}\"></a></li>"
      end
      artist_info += "</ul>"
    end
    artist_info
  end
end

get '/artista/:id' do
  service = ArtistService.new
  @artist = service.get_artist(params[:id])
  haml :artist
end

get '/artistas/:name' do
  service = ArtistService.new
  @artists = service.get_artists_by_name(URI.unescape(params[:name]))
  haml :artists
end

post '/artistas' do
  if params[:name]
    name = URI.escape(params[:name])
    redirect "/artistas/#{name}"
  end
end

get '/obras/:id' do
  service = ArtworkService.new
  @artwork = service.get_artwork(params[:id])
  haml :artwork
end

get '/obras/tecnica/:technique' do
  service = ArtworkService.new
  @artworks = service.get_artwork_by_technique(URI.unescape(params[:technique]))
  haml :artworks
end

post '/obras/tecnica' do
  redirect "/obras/tecnica/#{URI.escape(params[:technique])}"
end

post '/buscar_wikipedia' do
  @results = WikipediaService.search(params[:name])
  haml :wikipedia
end
