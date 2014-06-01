class PagesController < ApplicationController
  before_filter :set_current_location

  BURLINGTON = Zips.find_from_zip("05401")

    def home
        survey_response = create_survey_response
        save_survey_response(survey_response)
    end

	def zip_lookup
		lat = params[:lat].to_f
		long = params[:long].to_f
		render json: Zips.find_from_lat_long(lat, long)
	end

    def type_post
      found_zip = if params[:zip].present?
                    set_location_from_zip params[:zip]
                  end

      if !found_zip
        redirect_to "/", :notice => "Please provide a zip code. We need to know where you are!"
        return
      end

        survey_response = load_survey_response

        survey_response.merge!({
            "zip_code" => params[:zip] ? params[:zip] : nil,
            "location" => params[:zip] ? @current_location : nil,
            "food_description" => params[:food_description] ? params[:food_description] : nil,
            "is_prepared" => params[:answer].to_i == 1 ? true : false
        })

        # TODO Validate that zip and description were submitted

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

        survey_response.merge!({
            "is_opened" => params[:answer].to_i == 1 ? true : false
        })

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

        survey_response.merge!({
            "is_dangerous_temperature" => params[:answer].to_i == 1 ? true : false
        })

        save_survey_response(survey_response)

        # If not human consumable, redirect to results
        if survey_response["is_dangerous_temperature"]
            redirect_to "/results"
        else
            redirect_to "/age"
        end
    end

    def age
    end

    def age_post
        survey_response = load_survey_response

        survey_response.merge!({
            "is_too_old" => params[:answer].to_i == 1 ? true : false
        })

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

        survey_response.merge!({
            "is_distressed" => params[:answer].to_i == 1 ? true : false
        })

        save_survey_response(survey_response)

        redirect_to "/results"
    end

    def results
      @results = Org.all.sort_by {|org| org.distance_from(@current_location) }
    end

    private

      def set_current_location
        @current_location ||= session[:location] || BURLINGTON
      end

      def set_location_from_zip zip
        location_hash = Zips.find_from_zip(zip)
        if location_hash
          @current_location = session[:location] = location_hash
        else
          false
        end
      end


    # TODO: Move to SurveyResponse model

        def load_survey_response
            JSON.parse( session["survey_response"] )
        end

        def save_survey_response(survey_response)
            session[:survey_response] = survey_response.to_json
        end

        def create_survey_response
            return {
                "id" => SecureRandom.uuid,
                "zip_code" => nil,
                "location" => nil,
                "food_description" => nil,
                "is_prepared" => nil,
                "is_opened" => nil,
                "is_distressed" => nil,
                "is_too_old" => nil,
                "is_dangerous_temperature" => nil
            }
        end
end
