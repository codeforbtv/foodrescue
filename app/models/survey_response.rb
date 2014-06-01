class SurveyResponse < ActiveRecord::Base
  before_create :default_values

  def default_values
    self.uuid = SecureRandom.uuid
  end

  def edible?
    edible = true

    if self.opened or self.dangerous_temperature or self.old or self.distressed
      edible = false
    end

    return edible
  end
end
