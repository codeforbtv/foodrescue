class PagesController < ApplicationController
    def home
    end

    def type_post
        survey_response = {
            "zip_code" => params[:zip] ? params[:zip].to_latlon.split(",").map(&:to_f) : nil,
            "is_prepared" => params[:answer].to_i == 1 ? true : false
        }

        save_survey_response(survey_response)

        # If not human consumable, redirect to results
        if survey_response["is_prepared"]
            redirect_to "/opened"
        else
            redirect_to "/distress"
        end
    end

    def opened
    end

    def opened_post
        survey_response = load_survey_response
        survey_response["is_opened"] = request.POST['answer'].to_i == 1 ? true : false

        save_survey_response(survey_response)

        # If not human consumable, redirect to results
        if survey_response["is_opened"]
            redirect_to "/results"
        else
            redirect_to "/danger-zone"
        end
    end

    def danger_zone
    end

    def danger_zone_post
        survey_response = load_survey_response
        survey_response["is_dangerous"] = request.POST['answer'].to_i == 1 ? true : false

        save_survey_response(survey_response)

        # If not human consumable, redirect to results
        if survey_response["is_dangerous"]
            redirect_to "/results"
        else
            redirect_to "/age"
        end
    end

    def age
    end

    def age_post
        survey_response = load_survey_response
        survey_response["is_too_old"] = request.POST['answer'].to_i == 1 ? true : false

        save_survey_response(survey_response)

        # If not human consumable, redirect to results
        if survey_response["is_too_old"]
            redirect_to "/results"
        else
            redirect_to "/distress"
        end
    end

    def distress
    end

    def distress_post
        survey_response = load_survey_response
        survey_response["is_distressed"] = request.POST['answer'].to_i == 1 ? true : false

        save_survey_response(survey_response)

        redirect_to "/results"
    end

    def results
      @current_location = {latitude:  44.49, longitude: -73.22}
      @results = Org.all.sort_by {|org| org.distance_from(@current_location) }
    end

    private

        # TODO: Move to SurveyResponse model
        def load_survey_response
            JSON.parse( session["survey_response"] )
        end

        # TODO: Move to SurveyResponse model
        def save_survey_response(survey_response)
            session[:survey_response] = survey_response.to_json
        end
end
