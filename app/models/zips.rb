require 'csv'

class Zips
  def self.load
    file = Rails.root.join("data", "vt_zips.csv")
    puts "reading csv"
    @lookup = {}
    headers = nil
    CSV.parse(File.read(file)) do |row|
      if headers.nil?
        headers = row
        next
      end
      data = {
          zip: row[headers.find_index("zip")],
          city: row[headers.find_index("primary_city")],
          county: row[headers.find_index("county")],
          latitude: row[headers.find_index("latitude")].to_f,
          longitude: row[headers.find_index("longitude")].to_f,
      }
      @lookup[data[:zip]] = data
    end
  end

  def self.find_from_zip zip
    load unless @lookup
    @lookup[zip]
  end
  
  def self.find_from_lat_long lat, long
  	load unless @lookup
  	@lookup.sort_by do |key, value| 
  		distance_from(lat, long, value) 
  	end.first.first
  end
  
  def self.distance_from lat, long, loc
  	  source = GeoPoint.new latitude: loc[:latitude], longitude: loc[:longitude]
  	  target = GeoPoint.new latitude: lat, longitude: long
  	  source.distance_to target  	
  end
  
end
