class Toilet < ActiveRecord::Base

  # FIXME! Should be in a module :)

  RAD_PER_DEG = 0.017453293 
  Rkm = 6371              

  scope :near, lambda{ |*args|
                          origin = args.first[:origin]
                          
                          toilet_id = ""
                          if (origin).is_a?(Array)
                            origin_lat, origin_lng = origin
                            toilet_id = ""
                          else
                            origin_lat, origin_lng = origin.lat, origin.lng
                            toilet_id = "toilets.id != '#{origin.id}' AND"
                          end

                          origin_lat, origin_lng = (origin_lat * (Math::PI / 180)), (origin_lng * (Math::PI / 180))
                          within = args.first[:within]
                          
                          {
                            :conditions => %( 
                              #{toilet_id}
                              (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(toilets.lat))*COS(RADIANS(toilets.lng))+
                              COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(toilets.lat))*SIN(RADIANS(toilets.lng))+
                              SIN(#{origin_lat})*SIN(RADIANS(toilets.lat)))*6371) <= #{within}
                            ),
                            :select => %( toilets.*,
                              (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(toilets.lat))*COS(RADIANS(toilets.lng))+
                              COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(toilets.lat))*SIN(RADIANS(toilets.lng))+
                              SIN(#{origin_lat})*SIN(RADIANS(toilets.lat)))*6371) AS distance
                            )
                          }
                        }
                        
  def distance_from(point, options={})
    lat1, lon1 = self.lat, self.lng
    lat2, lon2 = point
    
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    
    dlon_rad, dlat_rad = to_radians(dlon, dlat)
    lat1_rad, lon1_rad, lat2_rad, lon2_rad = to_radians(lat1, lon1, lat2, lon2)
    
    a = (Math.sin(dlat_rad/2))**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * (Math.sin(dlon_rad/2))**2
    c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
    
    dKm = Rkm * c
  end
  
  def bearing_from(point, options={})

    lat1, lon1 = point 
    lat2, lon2 = self.lat, self.lng
    
    lat1, lon1, lat2, lon2 = to_radians(lat1, lon1, lat2, lon2)
    
    # compute deltas
    dlat = lat2 - lat1
    dlon = lon2 - lon1
  
    y = Math.sin(dlon) * Math.cos(lat2)
    x = Math.cos(lat1) * Math.sin(lat2) -
         Math.sin(lat1) * Math.cos(lat2) * Math.cos(dlon)
    
    bearing = Math.atan2(x,y)
    (90 - to_degrees(bearing) + 360) % 360
    
  end
  
  def to_degrees(*args)
    args = args.first if args.first.is_a?(Array)
    if args.size == 1
      (args.first * 180.0) / Math::PI
    else
      args.map{ |i| to_degrees(i) }
    end
  end
  
   def to_radians(*args)
     args = args.first if args.first.is_a?(Array)
     if args.size == 1
       args.first * (Math::PI / 180)
     else
       args.map{ |i| to_radians(i) }
     end
   end
   
   def to_param
     "#{self.id}-#{ActiveSupport::Inflector.transliterate(self.location).parameterize}"
   end
  
end
