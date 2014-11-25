require 'requests'

# Public - Access Wikipedia API
module WikipediaService
  # Public - Search wikipedia articles with this search string
  #
  # term - search String
  def self.search(term)
    base_uri = 'http://es.wikipedia.org/w/api.php'
    params = {
      action: 'query',
      list: 'search',
      format: 'json',
      srsearch: term
    }
    # Wikipedia requires us to identify ourselves:
    header = {
      'User-agent' =>
      'MNAV Open Data front-end - https://github.com/picandocodigo/mnav-opendata-front-end'
    }
    data = Requests.get(base_uri, headers: header, params: params)
    # require 'byebug'; byebug
    data['query']['search']
  end
end
