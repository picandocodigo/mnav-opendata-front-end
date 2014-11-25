require 'sinatra'
require 'haml'
require 'sass'
require './lib/artist_service.rb'
require './lib/artwork_service.rb'
require './lib/wikipedia_service.rb'
require './helpers.rb'

get '/style.css' do
  content_type 'text/css', charset: 'utf-8'
  scss :style
end

get '/' do
  @title = 'Inicio'
  service = ArtistService.new
  @artists = service.get_top_artists(10)
  haml :index
end

get '/acerca-de' do
  @title = 'Acerca de'
  haml :about
end

get '/contacto' do
  @title = 'Contacto'
  haml :contact
end

get '/datos-abiertos' do
  @title = 'Datos abiertos'
  haml :open_data
end

get '/artista/:id' do
  service = ArtistService.new
  @artist = service.get_artist(params[:id])
  @title = @artist['display_name']
  haml :artist
end

get '/artistas/:name' do
  @title = "B&uacute;squeda de artistas: #{params[:name]}"
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
  @title = @artwork['title']
  haml :artwork
end

get '/obras/tecnica/:technique' do
  @title = "B&uacute;squeda de obras: #{params[:technique]}"
  service = ArtworkService.new
  @artworks = service.get_artwork_by_technique(URI.unescape(params[:technique]))
  haml :artworks
end

post '/obras/tecnica' do
  redirect "/obras/tecnica/#{URI.escape(params[:technique])}"
end

post '/buscar_wikipedia' do
  @title = "Buscar en Wikipedia: #{params[:name]}"
  @results = WikipediaService.search(params[:name])
  haml :wikipedia
end
