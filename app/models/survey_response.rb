class SurveyResponse < ActiveRecord::Base
    before_create :default_values

    def default_values
        self.uuid = SecureRandom.uuid
    end
end
