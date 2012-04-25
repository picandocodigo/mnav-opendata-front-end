require './index'
# Replace the directory names to taste
use Rack::Static, :urls => ['/stylesheets', '/javascripts'], :root => 'public'
run Sinatra::Application