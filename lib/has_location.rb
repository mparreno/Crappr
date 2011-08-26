module HasLocation 
  
  RAD_PER_DEG = 0.017453293 
  Rkm = 6371
  
  def self.included(base)

    base.class_eval do
      scope :near, lambda{ |*args|
                              origin = args.first[:origin]
                              within = args.first[:within]
                              table = base.table_name
                              exclude_id = ""
                              
                              if (origin).is_a?(Array)
                                origin_lat, origin_lng = origin[0].to_f, origin[1].to_f
                                exclude_id = ""
                              else
                                origin_lat, origin_lng = origin.lat, origin.lng
                                exclude_id = "#{table}.id != '#{origin.id}' AND"
                              end

                              origin_lat, origin_lng = (origin_lat * (Math::PI / 180)), (origin_lng * (Math::PI / 180))
                              

                              {
                                :conditions => %( 
                                  #{exclude_id}
                                  (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(#{table}.lat))*COS(RADIANS(#{table}.lng))+
                                  COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(#{table}.lat))*SIN(RADIANS(#{table}.lng))+
                                  SIN(#{origin_lat})*SIN(RADIANS(#{table}.lat)))*6371) <= #{within}
                                ),
                                :select => %( #{table}.*,
                                  (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(#{table}.lat))*COS(RADIANS(#{table}.lng))+
                                  COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(#{table}.lat))*SIN(RADIANS(#{table}.lng))+
                                  SIN(#{origin_lat})*SIN(RADIANS(#{table}.lat)))*6371) AS distance
                                )
                              }
                            }
    end
    
    base.instance_eval do
      
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

    end
    
  end
  
  
  
end