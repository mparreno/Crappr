class Toilet < ActiveRecord::Base
  include HasLocation
  
  # Associations
  has_many :ratings
  belongs_to :suburb
  
  # Validations
  # Needs: Lat, Long, Location
  
  # Scopes
  scope :top_ids, lambda { |limit|
        joins(:ratings).
        select('toilets.id, AVG(ratings.value) AS average').
        group('toilets.id').
        order('average desc').
        limit(limit)
    }
  
  # Class Methods
  def self.top(num)
    toilets = []
    top_ids(num).each do |t|
      toilets << find(t.id)
    end
    toilets
  end
  
  # Instance Methods   
  def rating
    ratings.average(:value).try(:round) 
  end   
                    
  def to_param
    "#{self.id}-#{ActiveSupport::Inflector.transliterate(self.location).parameterize}"
  end
  
end
