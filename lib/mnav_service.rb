require 'yaml'
require 'httparty'

# Public - Generic class for http access on the MNAV API
class MNAVService
  include HTTParty
  format :json

  # Public - Constructor
  #
  # Get the base_uri from api_info.yaml
  def initialize
    api_info = YAML::load_file("./data/api_info.yaml")
    @base_uri = api_info['api_host']
  end

  # Public - Generic method for retrieving data
  #
  # url - the query url, mandatory
  # query - optional, some queries worked with the party, some didn't
  def get_data(url, query = nil)
    url = "#{@base_uri}/#{url}/"
    if(query)
      data = HTTParty.get(url, :query => query)
    else
      data = HTTParty.get(url)
    end
    return data.parsed_response
  end
end
