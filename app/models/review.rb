class Review < ActiveRecord::Base
  # Associations
  belongs_to :toilet
  
  # Validations
  validates_presence_of :value, :name
  
  # Value needs to be a number
end
