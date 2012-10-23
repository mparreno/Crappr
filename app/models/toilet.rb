class Toilet < ActiveRecord::Base
  include HasLocation
  include ToiletsHelper
  
  # Associations
  has_many :reviews
  belongs_to :suburb
  
  # Validations
  validates_presence_of :location
  validates_numericality_of :lat, :greater_than_or_equal_to => -90.0, :less_than_or_equal_to => 90.0
  validates_numericality_of :lng, :greater_than_or_equal_to => -180.0, :less_than_or_equal_to => 180.0
  
  # Scopes
  scope :top_ids, lambda { |limit|
        joins(:reviews).
        select('toilets.id').
        group('toilets.id').
        order('AVG(reviews.value) desc').
        limit(limit)
    }

  scope :in_suburb, lambda { |suburb_id| 
    suburb_id ? where(:suburb_id => suburb_id) : where('1=1')
  }

  scope :nearby, lambda { |lat, lng|
    return scoped unless lat && lng
    default_range = 500
    near(:origin => [lat.to_f, lng.to_f], :within => default_range)
  }  

  # Class Methods
  def self.top(num)
    return scoped if num.nil?
    self.where(:id => top_ids(num))
  end
  
  # Instance Methods   
  def rating
    reviews.average(:value).try(:round) 
  end
  
  def rating_count
    reviews.count
  end
  
  # Dirty hack!! 
  # Found issue here: https://rails.lighthouseapp.com/projects/8994/tickets/4840-to_xml-doesnt-work-in-such-case-eventselecttitle-as-tto_xml
  # TODO: fix later
  def dist
    if respond_to?(:distance)
      distanceize(distance, "m", false)
    end
  end
                    
  def to_param
    "#{self.id}-#{ActiveSupport::Inflector.transliterate(self.location).parameterize}"
  end
  
end
