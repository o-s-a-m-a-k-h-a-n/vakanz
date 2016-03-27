class Month < ActiveRecord::Base
  
  has_many :average_high_temperatures
  has_many :average_low_temperatures
  has_many :daily_mean_temperatures
  has_many :ideal_months

  validates :name, presence: true, uniqueness: true
end