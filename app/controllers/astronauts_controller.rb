class AstronautsController < ApplicationController
  def index
    @astronauts = Astronaut.all.includes(:missions)
    @avg_age = Astronaut.avg_age
  end
end
