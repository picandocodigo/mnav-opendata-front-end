require 'sinatra'
require 'haml'
require './lib/artist_service.rb'

get '/' do
  haml :index
end

get '/artists/:name' do
  service = ArtistService.new
  @artists = service.get_artists_by_name(params[:name])
  haml :artists
end
#get - artists
#get - artworks
