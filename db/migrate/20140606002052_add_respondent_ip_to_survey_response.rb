class AddRespondentIpToSurveyResponse < ActiveRecord::Migration
  def change
    add_column :survey_responses, :respondent_ip, :string, limit: 45
  end
end
