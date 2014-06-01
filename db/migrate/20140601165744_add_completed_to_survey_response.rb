class AddCompletedToSurveyResponse < ActiveRecord::Migration
  def change
    add_column :survey_responses, :completed, :boolean, :null => false, :default => false
  end
end
