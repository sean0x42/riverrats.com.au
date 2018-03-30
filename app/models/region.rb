require 'slug_helper'

class Region < ApplicationRecord

  include SlugHelper

  has_many :players_regions,
           class_name: 'PlayersRegions',
           dependent: :nullify
  has_many :players, through: :players_regions

  has_many :venues, dependent: :nullify

  validates :slug,
            presence: true,
            uniqueness: true

  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 3..64 }

  before_validation do
    self.slug = slugify(self.name)
  end

  def to_param
    slug
  end

end
