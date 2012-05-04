require './lib/mnav_service.rb'

# Public - Access MNAV API for artworks
class ArtworkService < MNAVService
  attr_reader :artworks, :artwork

  # Public - Get artwork by id
  #
  # id - Integer
  def get_artwork(id)
    self.get_data("artworks/#{id.to_i}")
  end

  # Public - Search artworks with certain technique
  #
  # technique - String
  def get_artwork_by_technique(technique)
    self.get_data("artworks", {:technique => technique})
  end

end
