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

get '/artist/:id' do
  service = ArtistService.new
  @artist = service.get_artist(params[:id])
  haml :artist, :layout => :layout
end

get '/artists/:name' do
  service = ArtistService.new
  @artists = service.get_artists_by_name(URI.unescape(params[:name]))
  haml :artists, :layout => :layout
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
  haml :artworks, :layout => :layout
end

post '/artworks/technique' do
  redirect "/artworks/technique/#{URI.escape(params[:technique])}"
end

post '/search_wikipedia' do
  @results = WikipediaService.search(params[:name])
  haml :wikipedia, :layout => :layout
end


get '/contact' do
  haml :contact, :layout => :layout
end

# Contact form
post '/contact' do 
  require 'pony'
  
  Pony.mail(
    # Configured for Heroku here:
    :name => params[:name],
    :mail => params[:mail],
    :body => params[:body],
    # Change contact e-mail here:
    :to => 'someone@somewhere.com',
    :subject => params[:name] + ' ' + params[:mail] + " has contacted you",
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  )
  
  redirect '/success' 
end

get '/success' do
  haml :success, :layout => :layout
end
