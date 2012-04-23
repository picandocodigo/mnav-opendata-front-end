require './lib/mnav_service.rb'

# Public - Access MNAV API for artworks
class ArtworkService < MNAVService
  attr_reader :artworks, :artwork

  # Public - Search artworks with certain technique
  #
  # technique - String
  def get_artwork_by_technique(technique)
    self.get_data("artworks", {:technique => technique})
  end

end
