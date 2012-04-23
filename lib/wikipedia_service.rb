require 'httparty'

# Public - Access Wikipedia API
module WikipediaService
  include HTTParty
  base_uri "http://es.wikipedia.org/w/api.php"

  #Wikipedia requires us to identify ourselves:
  headers 'User-agent' =>
    "MNAV Open Data front-end - https://github.com/picandocodigo/mnav-opendata-front-end"

  # Public - Search wikipedia articles with this search string
  #
  # term - search String
  def self.search(term)
    data = get("?action=query&list=search&format=json&srsearch=#{term}").parsed_response
    return data["query"]['search']
  end

end
