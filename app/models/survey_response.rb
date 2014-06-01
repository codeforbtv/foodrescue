class SurveyResponse < ActiveRecord::Base
  before_create :default_values

  def default_values
    self.uuid = SecureRandom.uuid
  end

  def edible?
    edible = true

    if opened or dangerous_temperature or old or distressed
      edible = false
    end

    return edible
  end
end
