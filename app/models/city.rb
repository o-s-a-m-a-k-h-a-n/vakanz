class City < ActiveRecord::Base
  
  has_many :average_high_temperatures
  has_many :average_low_temperatures
  has_many :daily_mean_temperatures
  has_many :ideal_months
  has_many :costs
  has_many :photos
  has_many :scores
  has_many :featured_images
end