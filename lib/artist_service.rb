require './lib/mnav_service.rb'

class ArtistService < MNAVService
  attr_reader :artist, :artists

  def initialize
    super
  end

  # Public - get an artist's info by id
  #
  # id - Integer
  #
  def get_artist(id)
    self.get_data("artists", {:id => id.to_i})
  end

  # Public - get artist searching by their name
  #
  # name - String
  #
  def get_artists_by_name(name)
    self.get_data("artists", {:name => name})
  end

  # Public - get artists by birth year
  #
  # birth - must be an Array with a year range
  #
  def get_artists_by_birth(birth)
    self.get_data("artists", {:birth => birth})
  end

end
