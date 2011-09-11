class Suburb < ActiveRecord::Base
  # Associations
  has_many :toilets
  
  default_scope order('name asc')
  
  def to_param
    "#{self.id}-#{ActiveSupport::Inflector.transliterate(self.name).parameterize}"
  end
  
end
