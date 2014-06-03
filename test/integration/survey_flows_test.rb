require 'test_helper'

class SurveyFlowsTest < ActionDispatch::IntegrationTest
  test "human edible prepared food" do
    visit_home
    food_is_prepared
    food_is_unopened
    food_is_fresh
    food_looks_good
    food_is_human_edible
  end

  test "human edible non-prepared food" do
    visit_home
    food_is_not_prepared
    food_looks_good
    food_is_human_edible
  end

  test "human inedible prepared food that has been opened" do
    visit_home
    food_is_prepared
    food_is_open
    food_is_not_human_edible
  end

  test "human inedible prepared food that has been a dangerous temperature" do
    visit_home
    food_is_prepared
    food_is_unopened
    food_is_dangerous_temperature
    food_is_not_human_edible
  end

  test "human inedible prepared food that is old" do
    visit_home
    food_is_prepared
    food_is_unopened
    food_is_temperature_safe
    food_is_old
    food_is_not_human_edible
  end

  test "human inedible prepared food that is distressed" do
    visit_home
    food_is_prepared
    food_is_unopened
    food_is_temperature_safe
    food_is_fresh
    food_looks_distressed
    food_is_not_human_edible
  end

  test "human inedible distressed non-prepared food" do
    visit_home
    food_is_not_prepared
    food_looks_distressed
    food_is_not_human_edible
  end

  private

    def visit_home
      get "/"
      assert_response :success
    end

    def food_is_prepared
      post_via_redirect "/type", zip: "05401", food_description: "lasagna", answer: "1"
      assert_equal '/opened', path
    end

    def food_is_not_prepared
      post_via_redirect "/type", zip: "05401", food_description: "lasagna", answer: "0"
      assert_equal '/distress', path
    end

    def food_is_open
      post_via_redirect "/opened", answer: "1"
      assert_equal '/results', path
    end

    def food_is_unopened
      post_via_redirect "/opened", answer: "0"
      assert_equal '/danger-zone', path
    end

    def food_is_temperature_safe
      post_via_redirect "/danger-zone", answer: "0"
      assert_equal '/age', path
    end

    def food_is_dangerous_temperature
      post_via_redirect "/danger-zone", answer: "1"
      assert_equal '/results', path
    end

    def food_is_fresh
      post_via_redirect "/age", answer: "0"
      assert_equal '/distress', path
    end

    def food_is_old
      post_via_redirect "/age", answer: "1"
      assert_equal '/results', path
    end

    def food_looks_distressed
      post_via_redirect "/distress", answer: "1"
      assert_equal '/results', path
    end

    def food_looks_good
      post_via_redirect "/distress", answer: "0"
      assert_equal '/results', path
    end

    def food_is_human_edible
      assert_select '.food-shelves.eligible'
    end

    def food_is_not_human_edible
      assert_select '.food-shelves' do |food_shelves|
        assert(!food_shelves[0].attributes['class'].include?('eligible'), 'Food shelves must not be eligible')
      end
    end

end
