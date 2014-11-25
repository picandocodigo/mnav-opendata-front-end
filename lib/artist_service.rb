require './lib/mnav_service.rb'
require './lib/wikipedia_service.rb'
require 'uri'

# Public - Access MNAV API for Artists
class ArtistService < MNAVService
  attr_reader :artist, :artists

  # Public - get an artist's info by id
  #
  # id - Integer
  #
  def get_artist(id)
    artist = get_data("artists/#{id.to_i}")
    artist['artworks'] = get_artist_artworks(id)
    artist
  end

  # Public - get artist searching by their name
  #
  # name - String
  #
  def get_artists_by_name(name)
    get_data('artists', name: name)
  end

  # Public - get artists by birth year
  #
  # birth - must be an Array with a year range
  #
  def get_artists_by_birth(birth)
    get_data('artists', birth: birth)
  end

  def get_top_artists(limit = 10)
    get_data('top/artists', limit: limit)
  end

  private

  # Internal - Get an artist's artworks
  #
  # id - artist's id
  def get_artist_artworks(id)
    get_data("artists/#{id}/artworks")
  end
end
