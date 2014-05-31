class Org < Hash

  def self.all
    from_file("foodshelf") + from_file("pig") + from_file("compost")
  end

  def self.from_file org_type
    raw = JSON.parse(File.read(Rails.root.join("data", org_type + ".json")))
    raw.map{|h| new(h)}
  end

  def initialize hash
    merge! hash
  end

  def distance_from current_location
    source = GeoPoint.new current_location
    target = GeoPoint.new latitude: self['lat'], longitude: self['lon']
    source.distance_to target
  end

end

