class StatesController < ApplicationController
  @states = State.all
  def index
    @states = State.all.order(:name)
  end
end
