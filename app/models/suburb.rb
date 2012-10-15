class Suburb < ActiveRecord::Base
  # Associations
  has_many :toilets
  validates_presence_of :name
  
  default_scope order('name asc')
  
  def to_param
    "#{self.id}-#{ActiveSupport::Inflector.transliterate(self.name).parameterize}"
  end
  
end
