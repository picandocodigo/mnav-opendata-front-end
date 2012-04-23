require './lib/mnav_service.rb'

class ArtworkService < MNAVService
  attr_reader :artworks, :artwork
  
  def initialize
    super
  end

  def get_artwork_by_technique(technique)
    self.get_data("artworks", {:technique => technique})
  end

end
