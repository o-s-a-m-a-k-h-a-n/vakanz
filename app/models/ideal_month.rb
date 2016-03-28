class IdealMonth < ActiveRecord::Base
  
  belongs_to :city
  belongs_to :month
end