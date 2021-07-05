class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    @particles_js = true
    @slogan = Faker::Quote.most_interesting_man_in_the_world
  end
end
