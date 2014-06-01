require 'csv'

class Zips
  def self.load
    file = Rails.root.join("data", "zip_code_database.csv")
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

  def self.find zip
    load unless @lookup
    @lookup[zip]
  end
end
