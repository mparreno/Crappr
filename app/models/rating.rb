class Rating < ActiveRecord::Base
  # Associations
  belongs_to :toilet
  
  # Validations
  # Needs: toilet_id, Value
  # Value needs to be a number
end
