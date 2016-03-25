class Month < ActiveRecord::Base
  has_many :average_high_temperatures

  validates :name, presence: true, uniqueness: true
end