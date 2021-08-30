class RoutesController < ApplicationController
  respond_to :json

  def_param_group :trip do
    property :id, Integer
    property :start_date, String, desc: "Starting date and time of this trip. "
    property :end_date, String, desc: "End date and time of this trip. "
    property :commute_time, Float, desc: "Seconds of the duration of this this trip. "
    property :price, Float, desc: "Price of the trip. "
    property :currency, String, desc: "Price currency. "
  end

  api :GET, '/search/', 'Shows filtered trips'
  param :start_date, String, desc: "Min starting date. Format: 'yyyy-mm-1dd hh:mm:ss'", required: true
  param :end_date, String, desc: "Max end date. Format: 'yyyy-mm-1dd hh:mm:ss' If not provided, end_date will be assumed to be end of day of starting date"
  param :start_id, String, desc: 'Starting city id. ', required: true
  param :destination_id, Integer, desc: 'Destination city id. ', required: true

  returns array_of: :trip, desc: "The search method delivers an array of all
    possible trips filtered by the filters provided. "
  def search
    attrs = search_params.to_hash
    attrs['end_date'] = params[:end_date].present? ?
      params['end_date'] :
      search_params[:start_date].to_datetime.at_end_of_day

    @paths = PathFinder.new(attrs).getAllPaths
  end

  private
  def search_params
    params.permit(
      :start_date,
      :start_id,
      :destination_id
    )
  end
end
