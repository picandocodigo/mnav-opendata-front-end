require 'yaml'
require 'requests'

# Public - Generic class for http access on the MNAV API
class MNAVService
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
      data = Requests.request("GET", url, params: query )
    else
      data = Requests.request("GET", url)
    end
    return JSON.parse data.body
  end
end
