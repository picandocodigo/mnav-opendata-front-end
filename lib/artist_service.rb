require 'yaml'
require 'httparty'


class ArtistService
  attr_reader :artist, :artists

  def initialize
    api_info = YAML::load_file("./data/api_info.yaml")
    @base_uri = api_info['api_host']
  end

  def get_artists_by_name(name)
    data = HTTParty.get("#{@base_uri}/artists/", :query => {:name => name})
    return data.parsed_response
  end

end
