class PagesController < ApplicationController
    def home
    end

    def type_post
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
      @results = Org.all
    end
end
