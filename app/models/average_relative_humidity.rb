class AverageRelativeHumidity < ActiveRecord::Base
  
  belongs_to :cities
  belongs_to :months
end