class CitiesController < ApplicationController
  def_param_group :city do
    property :name, String, desc: 'City name'
    property :id, String, desc: 'City id'
  end

  api :GET, '/cities/', 'Shows all cities'
  returns array_of: :city, desc: 'All cities.'
  def index
    @cities = City.all
  end
end
