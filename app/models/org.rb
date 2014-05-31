class Org

  def self.all
    from_file("foodshelf") + from_file("pig") + from_file("compost")
  end

  def self.from_file org_type
    JSON.parse(File.read(Rails.root.join("data", org_type + ".json")))
  end

end

