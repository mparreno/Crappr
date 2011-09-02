class Review < ActiveRecord::Base
  # Associations
  belongs_to :toilet
  
  # Validations
  validates_presence_of :text, :value
  
  # Value needs to be a number
end
