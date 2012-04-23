require 'httparty'

module WikipediaService
  include HTTParty
  base_uri "http://es.wikipedia.org/w/api.php"
  headers 'User-agent' =>
    "MNAV Open Data front-end - https://github.com/picandocodigo/mnav-opendata-front-end"

  def self.search(name)
    data = get("?action=query&list=search&format=json&srsearch=#{name}").parsed_response
    return data["query"]['search']
  end

end
