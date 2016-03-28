class AverageRainyDay < ActiveRecord::Base
  
  belongs_to :city
  belongs_to :month
end