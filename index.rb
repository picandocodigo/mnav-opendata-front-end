require 'sinatra'
require 'haml'
require './lib/artist_service.rb'
require './lib/artwork_service.rb'

get '/' do
  haml :index
end

get '/artist/:id' do
  service = ArtistService.new
  @artist = service.get_artist(params[:id])
  haml :artist, :layout => :layout
end

get '/artists/:name' do
  service = ArtistService.new
  @artists = service.get_artists_by_name(params[:name])
  haml :artists, :layout => :layout
end

post '/artists/' do
  if params[:name]
    redirect "/artists/#{params[:name]}"
  end
end

get '/artworks/technique/:technique' do
  service = ArtworkService.new
  @artworks = service.get_artwork_by_technique(params[:technique])
  haml :artworks, :layout => :layout
end

post '/artworks/technique/' do
  redirect "/artworks/technique/#{params[:technique]}"
end
