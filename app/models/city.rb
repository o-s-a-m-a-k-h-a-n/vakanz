class City < ActiveRecord::Base
  has_many :average_high_temperatures
  has_many :costs

  validates :name, presence: true, uniqueness: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end