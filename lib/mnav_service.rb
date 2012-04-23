require 'yaml'
require 'httparty'

class MNAVService
  include HTTParty
  format :json

  def initialize
    api_info = YAML::load_file("./data/api_info.yaml")
    @base_uri = api_info['api_host']
  end

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
