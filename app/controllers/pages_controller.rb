class PagesController < ApplicationController
    def home
    end

    def type_post
        # TODO: Pull survey_response from session
        survey_response = {
            "is_prepared_or_processed" => request.POST['answer'].to_i == 1 ? true : false
        }

        # Save to session
        session[:survey_response] = survey_response.to_json

        # TODO: Check if NOT human consumable, redirect to results
        if survey_response["is_prepared_or_processed"]
            redirect_to "/opened"
        else
            redirect_to "/results"
        end
    end

    def opened
        @survey_response = JSON.parse(session[:survey_response])
    end

    def opened_post
        redirect_to "/danger-zone"
    end

    def danger_zone
    end

    def danger_zone_post
        redirect_to "/age"
    end

    def age
    end

    def age_post
        redirect_to "/distress"
    end

    def distress
    end

    def distress_post
        redirect_to "/results"
    end

    def results
      @results = Org.all
    end
end
