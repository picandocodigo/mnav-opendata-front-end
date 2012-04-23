require 'yaml'
require 'httparty'

class MNAVService
  include HTTParty
  format :json

  def initialize
    api_info = YAML::load_file("./data/api_info.yaml")
    @base_uri = api_info['api_host']
  end

  def get_data(url, query)
    url = "#{@base_uri}/#{url}/"
    if(query[:id])
      data = HTTParty.get(url + query[:id].to_s)
    else
      data = HTTParty.get(url, :query => query)
    end
    return data.parsed_response
  end
end
