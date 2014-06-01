class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.string :uuid, limit: 40
      t.string :food_description, limit: 100
      t.string :zip_code, limit: 5
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.boolean :prepared
      t.boolean :opened
      t.boolean :dangerous_temperature
      t.boolean :old
      t.boolean :distressed

      t.timestamps
    end
  end
end
