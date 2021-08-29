class RoutesController < ApplicationController
  respond_to :json

  def search
    attrs = search_params.to_hash
    attrs['end_date'] = params[:end_date] ?
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
