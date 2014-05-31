class PagesController < ApplicationController
    def home
    end

    def type_post
        zip = params[:zip]
        if zip
          session[:location] = zip.to_latlon.split(",").map(&:to_f)
        end

        redirect_to "/opened"
    end

    def opened
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
      @current_location = {latitude:  44.49, longitude: -73.22}
      @results = Org.all.sort_by {|org| org.distance_from(@current_location) }
    end
end
