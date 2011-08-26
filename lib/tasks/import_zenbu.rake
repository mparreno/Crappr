require 'hpricot'
require 'fileutils'
require 'rake'

namespace :kml do
    desc "Import a KML file"
    task :import => :environment do
        filename = ENV['filename'].to_s 

        filehandle = File.open(filename, 'r')
        kml = Hpricot(filehandle)

        places = (kml/"kml/Folder/Placemark")
        puts "File: #{(kml/"Folder/name").inner_html} \n\n"
        puts "Preparing to import #{places.length} records \n\n"
        import_counter = 0
        places.each do |placemark|
          t = Toilet.new
          
          # SimpleData
          {
            "change_rm" => "change_rm",
            "gender" => "gender",
            "disabled" => "disabled",
            "open_hours" => "open_hou_1",
            "location" => "location"
          }.each_pair do |key, val|
            value = (placemark/"/extendeddata/schemadata/SimpleData[@name='#{val}']").inner_html
            
            if  val == "disabled" || val == "change_rm"
              value = (value == "Yes") ? true : false
            end
            
            t.send("#{key}=", value) 
          end
          
          # coordinates
          points = (placemark/"/point/coordinates").innerHTML.strip.split(',')
          t.lat = points[1].to_f
          t.lng = points[0].to_f
          
          # Suburb
          name = (placemark/"/extendeddata/schemadata/SimpleData[@name='suburb']").inner_html
          s = Suburb.find_or_create_by_name("#{name}")
          
          if t.valid?
            t.save!
            if s.valid?
               s.toilets << t
               s.save!
             end
            import_counter = import_counter + 1
            puts ". Toilet #{import_counter}"
          else
            puts "x"
          end
        end
        
        puts "Successfully imported #{import_counter} of #{places.length} records\n"
        
        filehandle.close     
    end
  
end