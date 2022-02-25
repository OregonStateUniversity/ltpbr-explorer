class StatesController < ApplicationController
  @states = State.select(*State.attribute_names.reject{ |attr| attr=='geom' })
  def index
    @states = State.select(*State.attribute_names.reject{ |attr| attr=='geom' }).order(:name)
  end
end
