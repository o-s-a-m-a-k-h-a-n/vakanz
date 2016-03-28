class Month < ActiveRecord::Base
  
  has_many :average_high_temperatures
  has_many :average_low_temperatures
  has_many :daily_mean_temperatures
  has_many :average_rainy_days
  has_many :average_relative_humidities

  validates :name, presence: true, uniqueness: true
end