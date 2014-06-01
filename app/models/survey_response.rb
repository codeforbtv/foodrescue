class SurveyResponse < ActiveRecord::Base
  before_create :default_values

  def default_values
    self.uuid = SecureRandom.uuid
  end

  def edible?
    return !(self.opened or self.dangerous_temperature or self.old or self.distressed)
  end
end
