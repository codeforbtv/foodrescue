class PagesController < ApplicationController
  before_filter :set_current_location

  BURLINGTON = Zips.find("05401")

  def set_current_location
    @current_location ||= session[:location] || BURLINGTON
  end

  def set_location_from_zip zip
    location_hash = Zips.find(zip)
    if location_hash
      @current_location = session[:location] = location_hash
    else
      false
    end
  end

  ###

  def home
  end

  def type_post
    found_zip = if params[:zip].present?
                  set_location_from_zip params[:zip]
                end

    if found_zip
      redirect_to "/opened"
    else
      redirect_to "/", :notice => "Please provide a zip code. We need to know where you are!"
    end
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
      @results = Org.all.sort_by {|org| org.distance_from(@current_location) }
    end
end
