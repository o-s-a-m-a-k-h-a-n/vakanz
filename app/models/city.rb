class City < ActiveRecord::Base
  
  has_many :average_high_temperatures
  has_many :costs
  has_many :photos
  has_many :scores
  has_many :featured_images
end