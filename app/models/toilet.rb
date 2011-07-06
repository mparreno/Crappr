class Toilet < ActiveRecord::Base
  include HasLocation
                    
   def to_param
     "#{self.id}-#{ActiveSupport::Inflector.transliterate(self.location).parameterize}"
   end
  
end
