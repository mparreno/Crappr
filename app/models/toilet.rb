class Toilet < ActiveRecord::Base
  include HasLocation
  include ToiletsHelper
  
  # Associations
  has_many :reviews
  belongs_to :suburbs
  
  # Validations
  # Needs: Lat, Long, Location
  
  # Scopes
  scope :top_ids, lambda { |limit|
        joins(:reviews).
        select('toilets.id, AVG(reviews.value) AS average').
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
    reviews.average(:value).try(:round) 
  end   
  
  # Dirty hack!! 
  # Found issue here: https://rails.lighthouseapp.com/projects/8994/tickets/4840-to_xml-doesnt-work-in-such-case-eventselecttitle-as-tto_xml
  # TODO: fix later
  def dist
    if try(:distance)
      distanceize(distance, "m", false)
    end
  end
                    
  def to_param
    "#{self.id}-#{ActiveSupport::Inflector.transliterate(self.location).parameterize}"
  end
  
end
