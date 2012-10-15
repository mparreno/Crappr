class Review < ActiveRecord::Base
  # Associations
  belongs_to :toilet
  
  default_scope order('created_at desc')
  
  # Validations
  validates_presence_of :value, :name
  
  # Value needs to be a number
  validates_numericality_of :value, :greater_than => 0, :less_than_or_equal_to => 5
  
end
