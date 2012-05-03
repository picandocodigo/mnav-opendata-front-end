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

get '/about' do
  haml :about
end

get '/contact' do
  haml :contact
end

get '/open-data' do
  haml :open_data
end

get '/artist/:id' do
  service = ArtistService.new
  @artist = service.get_artist(params[:id])
  haml :artist
end

get '/artists/:name' do
  service = ArtistService.new
  @artists = service.get_artists_by_name(URI.unescape(params[:name]))
  haml :artists
end

post '/artists' do
  if params[:name]
    name = URI.escape(params[:name])
    redirect "/artists/#{name}"
  end
end

get '/artworks/technique/:technique' do
  service = ArtworkService.new
  @artworks = service.get_artwork_by_technique(URI.unescape(params[:technique]))
  haml :artworks
end

post '/artworks/technique' do
  redirect "/artworks/technique/#{URI.escape(params[:technique])}"
end

post '/search_wikipedia' do
  @results = WikipediaService.search(params[:name])
  haml :wikipedia
end
